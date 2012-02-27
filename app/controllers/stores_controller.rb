class StoresController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:store_desc, :order_confirm, :video_show]
  before_filter :admin_permission, :only => [:new,:edit,:dstroy, :create, :index]
  
  uses_tiny_mce(:options => AppConfig.default_mce_options, :only => [:new, :edit, :add_videos])

  def store_desc
    if params[:store_id]
      @store=Store.find(params[:store_id])
    else
      @store=Store.first unless Store.first.nil?
    end
    @assets=Asset.all(:assetable_type => "image")
  end


  def order_confirm
    flash[:notice] = "Paypal payment successfully done."
    order=Order.get(params[:id])
    order.update(:confirm => true)
    OrderInfo.create!(:order_id => params[:id], :token => params["tx"], :status => params["st"], :amount => params["amt"], :currency => params["cc"])
    redirect_to :action => :store_desc
  end
  # GET /stores
  # GET /stores.xml
  def index
    if current_user.role?("admin")
      @stores=Store.all
    else
      @stores = current_user.stores
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stores }
    end
  end

  # GET /stores/1
  # GET /stores/1.xml
  def show
    @store = Store.get(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @store }
    end
  end

  # GET /stores/new
  # GET /stores/new.xml
  def new
    @store = Store.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @store }
    end
  end

  # GET /stores/1/edit
  def edit
    @store = Store.get(params[:id])
  end

  # POST /stores
  # POST /stores.xml
  def create
    @store = Store.new(params[:store])
    @store.save
    unless params[:image].nil?
      params[:image].each_value do |image|
        unless image.nil? || image[:photo].nil?
          @picture = Image.new
          @picture.source_file_name = image[:photo].original_filename
          @picture.source_content_type = image[:photo].original_filename.split(".").last
          #@picture.source_file_size = File.size(params[:image][:photo])
          @picture.source_updated_at =Time.now

          @picture.photo = image[:photo]
          @picture.save

          @asset=Asset.new
          @asset.assetable_id = @picture.id
          @asset.assetable_type = "image"
          @asset.price = image[:price][:price]
          @asset.store_id = @store.id
          @asset.save!
        end
      end
    end

    unless params[:video].nil?
      params[:video].each_value do |video|
        unless video.nil? || video[:file].nil?
          file = video[:file]
          @movie=Video.new
          name= video[:file].original_filename
          dir= RAILS_ROOT + "/public/movies"
          Dir.mkdir(dir) unless File.directory?(dir)
          path=File.join(dir,name)
          if File.extname(path) == ".swf" || File.extname(path) == ".mpeg" || File.extname(path) == ".wmv" || File.extname(path) == ".flv" || File.extname(path) == ".mpeg4" || File.extname(path) == ".mpg" || File.extname(path) == ".avi"
            parse_file = File.open(path, "wb") { |f| f.write(file.read) }

            @video=Video.new(:source_file_name => name, :source_file_size => File.new(path).size, :source_updated_at => Time.now, :source_content_type => File.extname(path))
            @video.title = video[:title]
            @video.description = video[:description]
            @video.save!
            @video.category_videos.create(:category_id =>  video[:category][:category_id].to_i)
            set_video_search(@video.id,video[:title], video[:description])
            image_file=video[:image][:photo]
            @image=VideoImage.new
            dir=RAILS_ROOT + "/public/video_image"
            name= video[:image][:photo].original_filename
            path=File.join(dir,name)
            Dir.mkdir(dir) unless File.directory?(dir)
            parse_file = File.open(path, "wb") { |f| f.write(image_file.read) }
            system("convert #{path} -resize 400x225\!  #{path}")
            @image.source_file_name = video[:image][:photo].original_filename
            @image.source_content_type = video[:image][:photo].original_filename.split(".").last
            @image.photo = video[:image][:photo]
            #          @image.source_file_size = File.size(video[:image][:photo])
            @image.source_updated_at =Time.now
            @image.video_id = @video.id
            @image.save!

            @asset = Asset.new
            @asset.assetable_id = @video.id
            @asset.assetable_type = "video"
            @asset.store_id = @store.id
            @asset.price = video[:price][:price]
            @asset.save!
          end
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to stores_path }
      format.xml  { render :xml => @store, :status => :created, :location => @store }
    end
  end
 
  def video_show
    @video=Video.get(params[:id])
    render :layout => false
  end


  # PUT /stores/1
  # PUT /stores/1.xml
  def update
    @store = Store.get(params[:id])

    unless params[:image].nil?
      params[:image].each_value do |image|
        unless image.nil? || image[:photo].nil?
          @picture = Image.new
          @picture.source_file_name = image[:photo].original_filename
          @picture.source_content_type = image[:photo].original_filename.split(".").last
          #@picture.source_file_size = File.size(params[:image][:photo])
          @picture.source_updated_at =Time.now

          @picture.photo = image[:photo]
          @picture.save

          @asset=Asset.new
          @asset.assetable_id = @picture.id
          @asset.assetable_type = "image"
          @asset.price = image[:price][:price]
          @asset.store_id = @store.id
          @asset.save!
        end
      end
    end

    unless params[:video].nil?
      params[:video].each_value do |video|
        unless video.nil? || video[:file].nil?
          file = video[:file]
          @movie=Video.new
          name= video[:file].original_filename
          dir= RAILS_ROOT + "/public/movies"
          Dir.mkdir(dir) unless File.directory?(dir)
          path=File.join(dir,name)
          if File.extname(path) == ".swf" || File.extname(path) == ".mpeg" || File.extname(path) == ".wmv" || File.extname(path) == ".flv" || File.extname(path) == ".mpeg4" || File.extname(path) == ".mpg" || File.extname(path) == ".avi"
            parse_file = File.open(path, "wb") { |f| f.write(file.read) }

            @video=Video.new(:source_file_name => name, :source_file_size => File.new(path).size, :source_updated_at => Time.now, :source_content_type => File.extname(path))
            @video.title = video[:title]
            @video.description = video[:description]
            @video.save!
            @video.category_videos.create(:category_id =>  video[:category][:category_id].to_i)
            image_file=video[:image][:photo]
            @image=VideoImage.new
            dir=RAILS_ROOT + "/public/video_image"
            name= video[:image][:photo].original_filename
            path=File.join(dir,name)
            Dir.mkdir(dir) unless File.directory?(dir)
            parse_file = File.open(path, "wb") { |f| f.write(image_file.read) }
            system("convert #{path} -resize 400x225\!  #{path}")
            @image.source_file_name = video[:image][:photo].original_filename
            @image.source_content_type = video[:image][:photo].original_filename.split(".").last
            @image.photo = video[:image][:photo]
            #          @image.source_file_size = File.size(video[:image][:photo])
            @image.source_updated_at =Time.now
            @image.video_id = @video.id
            @image.save!


            @asset = Asset.new
            @asset.assetable_id = @video.id
            @asset.assetable_type = "video"
            @asset.store_id = @store.id
            @asset.price = video[:price][:price]
            @asset.save!
          end
        end
      end
    end
    respond_to do |format|
      if @store.update(params[:store])
        format.html { redirect_to(edit_store_path(@store), :notice => 'Store was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @store.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.xml
  def destroy
    @store = Store.get(params[:id])
    @asset=Asset.all(:store_id => @store.id)
    unless @asset.nil?
      @asset.each do |asset|
        if asset.assetable_type == "image"
          @image=Image.get(asset.assetable_id)
          @image.destroy unless @image.nil?
        elsif asset.assetable_type == "video"
          @video=Video.get(asset.assetable_id)
          File.delete(RAILS_ROOT+"/public/movies/"+@video.source_file_name) if File.exist?(RAILS_ROOT+"/public/movies/"+@video.source_file_name)
          @video.video_image.destroy
          File.delete(RAILS_ROOT+"/public/video_image/"+@video.video_image.source_file_name) if File.exist?(RAILS_ROOT+"/public/video_image/"+@video.video_image.source_file_name)
          @video.destroy unless @video.nil?
        end

      end
      
    end
    Asset.all.destroy
    @store.destroy

    respond_to do |format|
      format.html { redirect_to(stores_url) }
      format.xml  { head :ok }
    end
  end

  def add_images
   
  end

  def add_videos
  end

  def add_content

  end


  def search
    if params[:category_id] == "Select"
      if params[:search] == ""
        @videos=[]
      else
        @videos=Video.search(params[:search]).results
      end
      
    elsif params[:search].nil? || params[:search] == ""
      @videos=Category.get(params[:category_id]).videos unless params[:category_id] == "Select"
    else
      @videos=Category.get(params[:category_id]).videos.search(params[:search]).results
    end
  end
end
