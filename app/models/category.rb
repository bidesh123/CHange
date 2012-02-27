class Category

  include DataMapper::Resource

  has n, :category_videos
  has n, :videos, :through => :category_videos

  property :id, Serial
  property :name, String
  property :updated_at, DateTime
  property :created_at, DateTime
end
