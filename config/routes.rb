Lostbets::Application.routes.draw do
  


 

  devise_for :users, :controllers => {:registrations => "registrations"}

  namespace "admin" do
    resources :set_roles
    resources :set_users
  end
  resources :contents
  resources :pictures
  resources :movies
  resources :other_videos do
    get "add_images", :on => :collection
    put "update_video", :on => :collection
    delete "update_image", :on => :collection
    get "subscription", :on => :collection
  end
  resources :carts do
    post "add_to_cart", :on => :collection
    post "empty_cart", :on => :collection
    get "checkout", :on => :collection
    post "save_order", :on => :collection
    get "order_details", :on => :collection
  end
  #  post 'carts/add_to_cart'
  resources :stores do
    get "store_desc", :on => :collection
    get "add_images", :on => :collection
    get "add_videos", :on => :collection
    get "add_content", :on => :collection
    get "order_confirm", :on => :collection
    get "video_show", :on => :collection
    post "search", :on => :collection
  end
  resources :token_authentications, :only => [:create, :destroy]
  resources :user, :controller => "user"
  
  match 'signups' => 'home#signup_page', :as => :signups
  root :to => "home#index"
end
