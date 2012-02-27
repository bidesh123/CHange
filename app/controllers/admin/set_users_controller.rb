class Admin::SetUsersController < ApplicationController
  # GET /set_users
  # GET /set_users.xml
  def index
    @set_users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @set_users }
    end
  end

  # GET /set_users/1
  # GET /set_users/1.xml
  def show
    @set_user = User.get(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @set_user }
    end
  end

  # GET /set_users/new
  # GET /set_users/new.xml
  def new
    @set_user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @set_user }
    end
  end

  # GET /set_users/1/edit
  def edit
    @set_user = User.get(params[:id])
  end

  # POST /set_users
  # POST /set_users.xml
  def create
    @set_user = User.new(params[:set_user])

    respond_to do |format|
      if @set_user.save
        format.html { redirect_to(@set_user, :notice => 'Set user was successfully created.') }
        format.xml  { render :xml => @set_user, :status => :created, :location => @set_user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @set_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /set_users/1
  # PUT /set_users/1.xml
  def update
    @set_user = User.get(params[:id])

    respond_to do |format|
      if @set_user.update(params[:user])
        format.html { redirect_to(admin_set_user_path(@set_user),  :notice => 'Set user was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @set_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /set_users/1
  # DELETE /set_users/1.xml
  def destroy
    @set_user = User.get(params[:id])
    @set_user.role_users.all.destroy unless @set_user.role_users.empty?
    @set_user.destroy

    respond_to do |format|
      format.html { redirect_to(admin_set_users_url) }
      format.xml  { head :ok }
    end
  end
end
