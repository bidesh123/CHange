class Role

  include DataMapper::Resource
  include DataMapper::MassAssignmentSecurity
  
  property :id, Serial
  property :name, String

  has n, :role_users
  has n, :users, :through => :role_users
end
