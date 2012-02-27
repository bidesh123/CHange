class MoviesController < ApplicationController
  #  skip_before_filter :authenticate_user!, :only => [:index]
  before_filter :admin_permission, :only => [:new,:edit,:dstroy, :create]
  uses_tiny_mce(:options => AppConfig.default_mce_options, :only => [:new, :edit])
  # GET /movies
  # GET /movies.xml
  def index
    if current_user.role?("admin")
      @movies = Video.all
    else
      @movies = []
      current_user.stores.each do |store|
        store.assets.all(:assetable_type => "video").each do |asset|
          @movies << Video.get(asset.assetable_id)
        end
      end
    end
  end

  # GET /movies/1
  # GET /movies/1.xml
  def show
    @movie = Video.get(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/new
  # GET /movies/new.xml
  def new
    @movie = Video.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/1/edit
  def edit
    @movie = Video.get(params[:id])
  end

  # POST /movies
  # POST /movies.xml
  
  def create
    file = params[:file]
    @movie=Video.new
    name= params[:file].original_filename
    dir= RAILS_ROOT + "/public/movies"
    Dir.mkdir(dir) unless File.directory?(dir)
    path=File.join(dir,name)
    if File.extname(path) == ".swf" || File.extname(path) == ".mpeg" || File.extname(path) == ".wmv" || File.extname(path) == ".flv" || File.extname(path) == ".mpeg4" || File.extname(path) == ".mpg" || File.extname(path) == ".avi"
      parse_file = File.open(path, "wb") { |f| f.write(file.read) }
   
      @video=Video.new(:source_file_name => name, :source_file_size => File.new(path).size, :source_updated_at => Time.now, :source_content_type => File.extname(path), :title => params[:title], :description => params[:description])
      @video.save!
      @video.category_videos.create(:category_id =>  params[:category_id].to_i)
      set_video_search(@video.id,params[:title], params[:description])
      image_file=params[:image]
      @image=VideoImage.new
      dir=RAILS_ROOT + "/public/video_image"
      name= params[:image].original_filename
      path=File.join(dir,name)
      Dir.mkdir(dir) unless File.directory?(dir)
      parse_file = File.open(path, "wb") { |f| f.write(image_file.read) }
      system("convert #{path} -resize 400x225\!  #{path}")
      @image.source_file_name = params[:image].original_filename
      @image.source_content_type = params[:image].original_filename.split(".").last
      @image.photo = params[:image]
      #          @image.source_file_size = File.size(video[:image][:photo])
      @image.source_updated_at =Time.now
      @image.video_id = @video.id
      @image.save!

      @asset = Asset.new
      @asset.assetable_id = @video.id
      @asset.assetable_type = "video"
      @asset.store_id = params[:store_id]
      @asset.price = params[:price]
      @asset.save!
      respond_to do |format|
      
        format.html { redirect_to(stores_path, :notice => 'Movie was successfully created.') }
        format.xml  { render :xml => @video, :status => :created, :location => @movie }
      
       
      end
    else
      flash[:notice] = "Only swf,flv,wmv,mpeg,mpeg4 videos can be upload here"
      render :action => "new"
      
    end
  end

  # PUT /movies/1
  # PUT /movies/1.xml
  def update
    @movie = Video.first(:id => params["id"])
    @asset=Asset.first(:assetable_id => @movie.id, :assetable_type => 'video')
    file = params[:file]
    
    name= params[:file].original_filename
    dir= RAILS_ROOT + "/public/movies"
    Dir.mkdir(dir) unless File.directory?(dir)
    path=File.join(dir,name)
    File.delete(@movie.source_file_name) if File.exists?(@movie.source_file_name)
    parse_file = File.open(path, "wb") { |f| f.write(file.read) }
        #    @movie.parse_file(File.new(path))
    @movie.update(:source_file_name =>  name, :source_content_type => File.extname(path).to_s,:source_file_size => File.new(path).size, :source_updated_at => Time.now)
    @asset.update(:assetable_id => @movie.id, :assetable_type => "video", :store_id => params[:store_id])
    
    respond_to do |format|
     
      format.html { redirect_to(movie_path(@movie), :notice => 'Movie was successfully updated.') }
      format.xml  { head :ok }
     
      format.html { render :action => "edit" }
      format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
     
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.xml
  def destroy
    @movie = Video.get(params[:id])
    File.delete("/movies/"+@movie.source_file_name) if File.exist?("/movies/"+@movie.source_file_name)
    @asset = Asset.first(:assetable_id => @movie.id, :assetable_type => 'video')
    @video_image=VideoImage.first(:video_id => @movie.id)
    File.delete("/video_image/" + @video_image.source_file_name) if File.exist?(("/video_image/" + @video_image.source_file_name))
    @video_image.destroy
    @asset.destroy
    @movie.destroy

    respond_to do |format|
      unless params[:value] == "edit_form"
        format.html { redirect_to(movies_url) }
      else
        format.html { redirect_to(edit_store_path(params[:store_id])) }
      end
      format.xml  { head :ok }
    end
  end


  
  
end

  
