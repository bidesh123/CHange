class VideoImage
  
  include DataMapper::Resource
  include DataMapper::MassAssignmentSecurity

  belongs_to :video
  property :id, Serial

  property :photo, String, :auto_validation => false
  property :source_file_name, String
  
  property :source_content_type, String
  property :source_file_size, Integer
  property :source_updated_at, DateTime

  mount_uploader :photo, AvatarUploader

end
