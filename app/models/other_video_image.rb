class OtherVideoImage

  include DataMapper::Resource
  belongs_to :other_video

  property :id, Serial
  property :image, String, :auto_validation => false
  property :file_size, Integer
  property :file_name,String
  mount_uploader :image, ImageUploader

end
