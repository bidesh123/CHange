class Order

  include DataMapper::Resource

  PAYMENT_TYPES = [
    #  Displayed        stored in db
    [ "Check",          "check" ],
    [ "Credit card",    "cc"   ],
    [ "Purchase order", "po" ]
  ]
  
  def add_line_items_from_cart(cart)
    cart.items.each do |item|
      li = LineItem.from_cart_item(item)
      line_items << li
    end
  end

  def paypal_url(return_url, price,name)
    values = {
      :business => 'kkj1_1300444127_biz@gmail.com',
      :cmd => '_xclick',
      :upload => 1,
      :return => return_url
    }
    values.merge!({
        "amount" => price,
        "item_name" => name,
        "quantity" => 1
      })
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
  
  has n, :line_items, :child_key => [ :order_id ]
  has n, :assets, :through => :line_items
  has 1, :order_info, :child_key => [:order_id]
  property :id, Serial
  property :name,String
  property :address, Text
  property :email, String
  property :pay_type, String
  property :confirm, Boolean
end
