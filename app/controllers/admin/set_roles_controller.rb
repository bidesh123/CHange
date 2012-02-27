class Admin::SetRolesController < ApplicationController
  # GET /set_roles
  # GET /set_roles.xml
  def index
    @set_roles = RoleUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @set_roles }
    end
  end

  # GET /set_roles/1
  # GET /set_roles/1.xml
  def show
    @set_role = Role.get(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @set_role }
    end
  end

  # GET /set_roles/new
  # GET /set_roles/new.xml
  def new
    @roles=Role.all
    @set_role = Role.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @set_role }
    end
  end

  # GET /set_roles/1/edit
  def edit
    @set_role = RoleUser.get(params[:id])
  end

  # POST /set_roles
  # POST /set_roles.xml
  def create
    @set_role = Role.new(params[:set_role])

    respond_to do |format|
      if @set_role.save
        format.html { redirect_to(@set_role, :notice => 'Set role was successfully created.') }
        format.xml  { render :xml => @set_role, :status => :created, :location => @set_role }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @set_role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /set_roles/1
  # PUT /set_roles/1.xml
  def update
    begin
      @set_role = RoleUser.get(params[:id])
      @set_role.update(:role_id => params[:role_id],:user_id => params[:user_id])
      
      respond_to do |format|
        format.html { redirect_to(admin_set_roles_path, :notice => 'Set role was successfully updated.') }
        format.xml  { head :ok }
      end
    rescue
      flash[:alert] = "Role is not updated for that user."
      render :action => "edit" 
    end
  end

  # DELETE /set_roles/1
  # DELETE /set_roles/1.xml
  def destroy
    @set_role = RoleUser.get(params[:id])
    @set_role.destroy

    respond_to do |format|
      format.html { redirect_to(admin_set_roles_url) }
      format.xml  { head :ok }
    end
  end
end
