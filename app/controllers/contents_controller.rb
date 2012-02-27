class ContentsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:index]
  before_filter :admin_permission, :only => [:new,:edit,:dstroy, :create]
  # GET /contents
  # GET /contents.xml
  uses_tiny_mce(:options => AppConfig.default_mce_options, :only => [:new, :edit])
   
  def index
     if current_user.role?("admin")
      @contents = Text.all
    else
      @contents = []
      current_user.stores.each do |store|
        store.assets.all(:assetable_type => "text").each do |asset|
          @contents << Text.get(asset.assetable_id)
        end
      end
    end

  end

  # GET /contents/1
  # GET /contents/1.xml
  def show
    @content = Text.get(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @content }
    end
  end

  # GET /contents/new
  # GET /contents/new.xml
  def new
    @content = Text.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @content }
    end
  end

  # GET /contents/1/edit
  def edit
    @content = Text.get(params[:id])
  end

  # POST /contents
  # POST /contents.xml
  def create
    @content = Text.new
    @content.body = params[:text][:body]
    @content.title = params[:text][:title]
    @content.save
    @asset=Asset.new
    @asset.assetable_id = @content.id
    @asset.assetable_type = "text"
    @asset.store_id = params[:store_id]
    @asset.price = params[:price]
    @asset.save!
    respond_to do |format|
      
        format.html { redirect_to(content_path(@content), :notice => 'Content was successfully created.') }
        format.xml  { render :xml => @content, :status => :created, :location => @content }
   
    end
  end

  # PUT /contents/1
  # PUT /contents/1.xml
  def update
    begin
    @content = Text.get(params[:id])
    @asset=Asset.first(:assetable_id => @content.id, :assetable_type => 'text')
    @content.update(:body => params[:text][:body], :title => params[:text][:title])
    @asset.update(:assetable_id => @content.id, :assetable_type => "text", :store_id => params[:store_id])
    respond_to do |format|
        format.html { redirect_to(content_path(@content), :notice => 'Content was successfully updated.') }
        format.xml  { head :ok }
    end
    rescue
      flash[:notice] = "Your Content is updated Successfully"
      render :action => "edit"

    end
  end

  # DELETE /contents/1
  # DELETE /contents/1.xml
  def destroy
    @content = Text.get(params[:id])
    @content.destroy

    respond_to do |format|
      format.html { redirect_to(contents_url) }
      format.xml  { head :ok }
    end
  end
end
