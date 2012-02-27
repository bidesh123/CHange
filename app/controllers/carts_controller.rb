class CartsController < ApplicationController
 
  skip_before_filter :authenticate_user!
  before_filter :find_cart

  def index

  end

  def new

  end

  def create

  end

  def edit

  end
  
  def update
    
  end
 
  def add_to_cart
    asset=Asset.get(params[:asset_id])
    @cart.add_product(asset)
    redirect_to :controller => "stores", :action => "store_desc"
  end

  def find_cart
    
    @cart = (session[:cart] ||= Cart.new)
  end

  def empty_cart
    session[:cart] = nil
    redirect_to :controller => "stores", :action => "store_desc"  
  end

  def checkout
    @order = Order.new
  end

  
  def order_details
    @order=Order.get(params[:order])
    @price=0
    @order.line_items.each do |li|
      @price += li.total_price
    end
  end



  def save_order
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(@cart)
    if @order.save
      session[:cart] = nil
      flash[:notice] = "Order Set successfully."
      price=0
      @order.line_items.each do |li|
        price = price + li.total_price
      end
      redirect_to :action => "order_details", :order => @order.id
    else
      render :action => :checkout
    end
  end
end
