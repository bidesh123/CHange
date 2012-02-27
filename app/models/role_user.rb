class RoleUser

  include DataMapper::Resource
 
  property :id, Serial

  belongs_to :role
  belongs_to :user

end
