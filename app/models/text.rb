class Text

  include DataMapper::Resource
  include DataMapper::MassAssignmentSecurity
  
  property :id, Serial

  property :body, Text
  property :title, String
  property :updated_at, DateTime

end
