class CartItem
  attr_reader :asset, :quantity

  def initialize(asset)
    @asset=asset
    @quantity = 1
  end

  def increment_quantity
    @quantity += 1
  end

  def type
    @type=@asset.assetable_type unless @asset.nil? || @asset.assetable_type.nil?
  end
 
  def image
    
    Image.get(@asset.assetable_id) unless @asset.nil? || @asset.assetable_id.nil?
  end

  def video
    Video.get(@asset.assetable_id) unless @asset.nil? || @asset.assetable_id.nil?
  end

  def price
    @asset.price * @quantity unless @asset.nil? 
  end


end
