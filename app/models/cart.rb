class Cart

  attr_reader :items

  def initialize
    @items = []
  end
  

  def add_product(asset)
    current_item = @items.find {|item| item.asset == asset}
    if current_item
      current_item.increment_quantity
    else
      current_item = CartItem.new(asset)
      @items << current_item
    end
    current_item
  end

  def total_items
    @items.sum { |item| item.quantity }
  end
end
