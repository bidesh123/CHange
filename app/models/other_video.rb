class OtherVideo

  include DataMapper::Resource

  has n,:other_video_images, :child_key => [:other_video_id]

  property :id, Serial
  property :demo_video_path, String
  property :title, String
  property :description, Text
  property :main_video_mp4, String
  property :main_video_mpeg,String
  property :main_video_wmv, String
 
end
