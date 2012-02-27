class OtherVideosController < ApplicationController

  skip_before_filter :authenticate_user!, :only =>[:index,:show, :subscription]
  uses_tiny_mce(:options => AppConfig.default_mce_options, :only => [:new, :edit, :add_videos])
  
  # GET /other_videos
  # GET /other_videos.xml
  def index
    @other_videos = OtherVideo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @other_videos }
    end
  end

  # GET /other_videos/1
  # GET /other_videos/1.xml
  def show
    @other_video = OtherVideo.get(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @other_video }
    end
  end

  # GET /other_videos/new
  # GET /other_videos/new.xml
  def new
    @other_video = OtherVideo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @other_video }
    end
  end

  # GET /other_videos/1/edit
  def edit
    @other_video = OtherVideo.get(params[:id])
  end

  # POST /other_videos
  # POST /other_videos.xml
  def create

    file = params[:demo_video]
    Dir.mkdir(RAILS_ROOT + "/public/main_videos") unless File.directory?(RAILS_ROOT + "/public/main_videos")

    Dir.mkdir(RAILS_ROOT + "/public/main_videos/mp4") unless File.directory?(RAILS_ROOT + "/public/main_videos/mp4")
    Dir.mkdir(RAILS_ROOT + "/public/main_videos/mpeg") unless File.directory?(RAILS_ROOT + "/public/main_videos/mpeg")
    Dir.mkdir(RAILS_ROOT + "/public/main_videos/wmv") unless File.directory?(RAILS_ROOT + "/public/main_videos/wmv")
    Dir.mkdir(RAILS_ROOT + "/public/main_videos/demo") unless File.directory?(RAILS_ROOT + "/public/main_videos/demo")
    
    @other_video=OtherVideo.new(params[:other_video])

    name= params[:demo_video].original_filename
    unless OtherVideo.last.nil?
      dir= RAILS_ROOT + "/public/main_videos/demo/#{(OtherVideo.last.id.to_i+1).to_s}"
    else
      dir= RAILS_ROOT + "/public/main_videos/demo/1"
    end
    Dir.mkdir(dir) unless File.directory?(dir)
    path=File.join(dir,name)
    if File.extname(path) == ".swf" || File.extname(path) == ".mpeg" || File.extname(path) == ".wmv" || File.extname(path) == ".flv" || File.extname(path) == ".mpeg4" || File.extname(path) == ".mpg" || File.extname(path) == ".avi"
      File.open(path, "wb") { |f| f.write(file.read) }
    end
    @other_video.demo_video_path = name
   
    #for mp4 file
    mp4_file = params[:main_video_mp4]
    mp4_name= params[:main_video_mp4].original_filename
    unless OtherVideo.last.nil?
      dir= RAILS_ROOT + "/public/main_videos/mp4/#{(OtherVideo.last.id.to_i+1).to_s}"
    else
      dir= RAILS_ROOT + "/public/main_videos/mp4/1"
    end
    Dir.mkdir(dir) unless File.directory?(dir)
    path=File.join(dir,mp4_name)
    if File.extname(path) == ".mp4"
      File.open(path, "wb") { |f| f.write(mp4_file.read) }
    end
    @other_video.main_video_mp4 = mp4_name
    #for download mpeg file
    mpeg_file = params[:main_video_mpeg]
    mpeg_name= params[:main_video_mpeg].original_filename
    unless OtherVideo.last.nil?
      dir= RAILS_ROOT + "/public/main_videos/mpeg/#{(OtherVideo.last.id.to_i+1).to_s}"
    else
      dir= RAILS_ROOT + "/public/main_videos/mpeg/1"
    end
    Dir.mkdir(dir) unless File.directory?(dir)
    path=File.join(dir,mpeg_name)
    if File.extname(path) == ".mpeg"
      File.open(path, "wb") { |f| f.write(mpeg_file.read) }
    end

    @other_video.main_video_mpeg = mpeg_name

    #for download wmv file
    wmv_file = params[:main_video_wmv]
    wmv_name= params[:main_video_wmv].original_filename
    unless OtherVideo.last.nil?
      dir= RAILS_ROOT + "/public/main_videos/wmv/#{(OtherVideo.last.id.to_i+1).to_s}"
    else
      dir= RAILS_ROOT + "/public/main_videos/wmv/1"
    end
    Dir.mkdir(dir) unless File.directory?(dir)
    path=File.join(dir,wmv_name)
    if File.extname(path) == ".wmv"
      File.open(path, "wb") { |f| f.write(wmv_file.read) }
    end
    @other_video.main_video_wmv =  wmv_name
    @other_video.save!
    params[:image].each_value do |image|
      @other_video.other_video_images.create(:image => image[:video_image])
    end
    @store=Store.find_or_create(:title => "Other Video Store", :description => "This will store all other videos", :user_id => User.first.id)
    @asset=Asset.new
    @asset.assetable_id = @other_video.id
    @asset.assetable_type = "Other Video"
    @asset.store_id = @store.id
    @asset.save!
   
    respond_to do |format|
      if @other_video.save
        format.html { redirect_to(@other_video, :notice => 'Other video was successfully created.') }
        format.xml  { render :xml => @other_video, :status => :created, :location => @other_video }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @other_video.errors, :status => :unprocessable_entity }
      end
    end
  end

  def subscription
    
  end



  def add_images
    
  end
  # PUT /other_videos/1
  # PUT /other_videos/1.xml
  def update
    @other_video = OtherVideo.get(params[:id])


    if params[:demo_video]
      file = params[:demo_video]
      Dir.mkdir(RAILS_ROOT + "/public/main_videos/demo") unless File.directory?(RAILS_ROOT + "/public/main_videos/demo")
      name= params[:demo_video].original_filename
      dir= RAILS_ROOT + "/public/main_videos/demo/#{@other_video.id.to_s}"
      Dir.mkdir(dir) unless File.directory?(dir)
      path=File.join(dir,name)
      if File.extname(path) == ".swf" || File.extname(path) == ".mpeg" || File.extname(path) == ".wmv" || File.extname(path) == ".flv" || File.extname(path) == ".mpeg4" || File.extname(path) == ".mpg" || File.extname(path) == ".avi"
        File.open(path, "wb") { |f| f.write(file.read) }
      end
      @other_video.update(:demo_video_path => name)
    end
    
    if  params[:main_video_mp4]
      file = params[:main_video_mp4]
      Dir.mkdir(RAILS_ROOT + "/public/main_videos/mp4") unless File.directory?(RAILS_ROOT + "/public/main_videos/mp4")
      name= params[:main_video_mp4].original_filename

      dir= RAILS_ROOT + "/public/main_videos/mp4/#{@other_video.id.to_s}"

      Dir.mkdir(dir) unless File.directory?(dir)
      path=File.join(dir,name)
      if File.extname(path) == ".mp4"
        File.open(path, "wb") { |f| f.write(file.read) }
      end
      @other_video.update(:main_video_mp4 => name)

    end

    if params[:main_video_mpeg]
      file = params[:main_video_mpeg]
      Dir.mkdir(RAILS_ROOT + "/public/main_videos/mpeg") unless File.directory?(RAILS_ROOT + "/public/main_videos/mpeg")
      name= params[:main_video_mpeg].original_filename

      dir= RAILS_ROOT + "/public/main_videos/mpeg/#{@other_video.id.to_s}"

      Dir.mkdir(dir) unless File.directory?(dir)
      path=File.join(dir,name)
      if File.extname(path) == ".mpeg"
        File.open(path, "wb") { |f| f.write(file.read) }
      end
      @other_video.update(:main_video_mpeg => name)

    end

    if params[:main_video_wmv]
      file = params[:main_video_wmv]
      Dir.mkdir(RAILS_ROOT + "/public/main_videos/wmv") unless File.directory?(RAILS_ROOT + "/public/main_videos/wmv")
      name= params[:main_video_wmv].original_filename

      dir= RAILS_ROOT + "/public/main_videos/wmv/#{@other_video.id.to_s}"

      Dir.mkdir(dir) unless File.directory?(dir)
      path=File.join(dir,name)
      if File.extname(path) == ".wmv"
        File.open(path, "wb") { |f| f.write(file.read) }
      end
      @other_video.update(:main_video_wmv => name)

    end
    unless params[:image].nil?
      params[:image].each_value do |image|
        @other_video.other_video_images.create(:image => image[:video_image])
      end
    end
    respond_to do |format|
      if @other_video.update(params[:other_video])
        format.html { redirect_to(@other_video, :notice => 'Other video was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @other_video.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update_image
    @image=OtherVideoImage.find(params[:id])
    @image.destroy
    redirect_to :action => :edit, :id => params[:other_video_id]

  end

  def update_video
    @other_video = OtherVideo.get(params[:id])
    if params[:value] == "mp4"
      File.delete(RAILS_ROOT+"/public/main_videos/mp4/#{@other_video.id.to_s}/#{@other_video.main_video_mp4}") if File.exist?(RAILS_ROOT+"/public/main_videos/mp4/#{@other_video.id.to_s}/#{@other_video.main_video_mp4}")
      @other_video.update(:main_video_mp4 => nil)
    elsif params[:value] == "wmv"
      File.delete(RAILS_ROOT + "/public/main_videos/wmv/#{@other_video.id.to_s}/#{@other_video.main_video_wmv}") if File.exist?(RAILS_ROOT+"/public/main_videos/wmv/#{@other_video.id.to_s}/#{@other_video.main_video_wmv}")
      @other_video.update(:main_video_wmv => nil)
    elsif params[:value] == "mpeg"
      File.delete(RAILS_ROOT + "/public/main_videos/mpeg/#{@other_video.id.to_s}/#{@other_video.main_video_mpeg}") if File.exist?(RAILS_ROOT+"/public/main_videos/mpeg/#{@other_video.id.to_s}/#{@other_video.main_video_mpeg}")
      @other_video.update(:main_video_mpeg => nil)
    else
      File.delete(RAILS_ROOT + "/public/main_videos/demo/#{@other_video.id.to_s}/#{@other_video.demo_video_path}") if File.exist?(RAILS_ROOT+"/public/main_videos/demo/#{@other_video.id.to_s}/#{@other_video.demo_video_path}")
      @other_video.update(:demo_video_path => nil)
    end
      
    redirect_to :action => :edit, :id => @other_video.id
  end
  # DELETE /other_videos/1
  # DELETE /other_videos/1.xml
  def destroy

    @other_video = OtherVideo.get(params[:id])
    @other_video.destroy


    respond_to do |format|
      format.html { redirect_to(other_videos_url) }
      format.xml  { head :ok }
    end
  end

  def new_subscription
    
  end
end
