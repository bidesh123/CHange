class Video
  cattr_reader :per_page
  @@per_page = 2
  include DataMapper::Resource
  include DataMapper::MassAssignmentSecurity

  #   include Tire::Model::Persistence
  include Tire::Model::Search
  include Tire::Model::Callbacks

  index_name 'videos'

  def to_indexed_json
    self.to_json
  end

  def self.set_search
    Tire.index 'videos' do
      create :mappings => {
        :video => {
          :properties => {
            :id       => { :type => 'string', :index => 'not_analyzed', :include_in_all => false },
            :title    => { :type => 'string', :boost => 2.0,            :analyzer => 'keyword'  },
            :description     => { :type => 'string', :analyzer => 'keyword' }
          
          }
        }
      }
    end
  end

  has 1, :video_image, :child_key => [:video_id]
  has n, :categories, :through => :category_videos
  has n, :category_videos, :child_key => [:video_id]
  property :id, Serial
  property :source_file_name, String
  property :source_content_type, String
  property :source_file_size, Integer
  property :source_updated_at, DateTime
  property :title,String
  property :description, Text

end
