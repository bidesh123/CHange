class OrderInfo

  include DataMapper::Resource
    
  belongs_to :order

  property :id, Serial
  property :token, String
  property :status, String
  property :amount, Integer
  property :currency, String

end
