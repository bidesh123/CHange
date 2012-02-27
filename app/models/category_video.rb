class CategoryVideo

  include DataMapper::Resource
  
  belongs_to :category
  belongs_to :video

  property :id, Serial


end
