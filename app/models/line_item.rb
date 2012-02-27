class LineItem

  include DataMapper::Resource


  belongs_to :order
  belongs_to :asset

   def self.from_cart_item(cart_item)
    li = self.new
    li.asset     = cart_item.asset
    li.quantity    = cart_item.quantity
    li.total_price = cart_item.price
    li
  end

  property :id, Serial
  property :quantity, Integer
  property :total_price, Integer


end

