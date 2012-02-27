class Store

  include DataMapper::Resource
  include DataMapper::MassAssignmentSecurity

  include Tire::Model::Search
  include Tire::Model::Callbacks
  
  property :id, Serial

  property :description, Text
  property :title, String

  has n, :assets
  belongs_to :user, :model => User, :child_key => [:user_id]


  def self.all_store_selection(url)

    Store.all.map {|s| [s.title,"http://#{url}/stores/store_desc?store_id="+s.id.to_s]}
  end
end
