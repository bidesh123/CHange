class ApplicationController < ActionController::Base
  protect_from_forgery

  #  rescue_from CanCan::AccessDenied do |exception|
  #    redirect_to root_url, :alert => exception.message
  #  end
  before_filter :authenticate_user!


  protected

  def admin_permission
   
    if !current_user.role?("admin") && !current_user.role?("producer")
      flash[:alert] = "The page is only allowed only for admin and producer User"
      redirect_to root_path
    
    end
  end


  def set_video_search(id,title,description)
    Video.set_search
    Tire.index 'videos' do
      delete
      create
      store :id => id, :title => title,   :description => description
      refresh
    end

  end


end
