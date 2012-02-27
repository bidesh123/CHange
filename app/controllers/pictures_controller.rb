class PicturesController < ApplicationController
  
  
  before_filter :admin_permission, :only => [:new,:edit,:dstroy, :create]

  # GET /pictures
  # GET /pictures.xml
  def index
    if current_user.role?("admin")
      @pictures = Image.all
    else
      @pictures = []
      current_user.stores.each do |store|
        store.assets.all(:assetable_type => "image").each do |asset|
          @pictures << Image.get(asset.assetable_id)
        end
      end
    end
  end

 

  # GET /pictures/1
  # GET /pictures/1.xml
  def show
    @picture = Image.get(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @picture }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.xml
  def new
    @picture = Image.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
    @picture = Image.get(params[:id])
  end

  # POST /pictures
  # POST /pictures.xml
  def create
    @picture = Image.new
    ext= params[:image][:photo].original_filename.split(".").last
    if ext == "jpg" || ext == "jpeg" || ext == "gif" || ext == "png"
      @picture = Image.new
      @picture.source_file_name = params[:image][:photo].original_filename
      @picture.source_content_type = params[:image][:photo].original_filename.split(".").last
      #@picture.source_file_size = File.size(params[:image][:photo])
      @picture.source_updated_at =Time.now
      @picture.photo = params[:image][:photo]
      @picture.save
      
      @asset=Asset.new
      @asset.assetable_id = @picture.id
      @asset.assetable_type = "image"
      @asset.price = params[:price]
      @asset.store_id = params[:store_id]
      @asset.save!

      respond_to do |format|
      
        format.html { redirect_to(picture_path(@picture), :notice => 'Picture was successfully created.') }
        format.xml  { render :xml => @picture, :status => :created, :location => @picture }
      
      end
    else
      flash[:notice] = "Only jpg,gif,png,jpeg images can be upload here"
      render :action => "new"
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.xml
  def update
    @picture = Image.get(params[:id])
    @asset=Asset.first(:assetable_id => @picture.id, :assetable_type => 'image')
    if params[:image][:photo]
      @picture.update(:photo => params[:image][:photo],:source_file_name => params[:image][:photo].original_filename, :source_content_type => params[:image][:photo].original_filename.split(".").last, :source_updated_at => Time.now)
      @asset.update(:assetable_id => @picture.id, :assetable_type => "image", :store_id => params[:store_id])
      respond_to do |format|
        format.html { redirect_to(picture_path(@picture), :notice => 'Picture was successfully updated.') }
        format.xml  { head :ok }
      end
    else
      
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.xml
  def destroy
    @picture = Image.get(params[:id])
    @asset=Asset.first(:assetable_id => @picture.id, :assetable_type => "image")
    @asset.destroy
    @picture.destroy

    respond_to do |format|
      unless params[:value]
        format.html { redirect_to(pictures_url) }
      else
        format.html { redirect_to(edit_store_path(params[:store_id])) }
      end
      format.xml  { head :ok }
    end
  end
end
