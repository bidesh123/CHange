class User

  include DataMapper::Resource
  include DataMapper::MassAssignmentSecurity
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  ROLES = %w(admin producer consumer)

  property :id,                   Serial,              :required => true
  property :username,             String
  property :email,                String,              :required => true
  property :first_name,           String
  property :last_name,            String
  
  has n, :role_users, :child_key => [ :user_id ]
  has n, :roles, :through => :role_users
  has n, :stores
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me

  # ActiveRecord-compatible validations, only needed in case the validation module is used
  def self.validates_presence_of(name, options = {})
    local_name = I18n.t(name, :default => name, :scope => [:activerecord, :attributes, :user], :count => 1)
    validates_present(name, options.merge({:message => local_name+" must not be empty."}))
  end

  def self.validates_uniqueness_of(name, options = {})
    validates_is_unique(name, options)
  end

  def self.validates_format_of(name, options = {})
    validates_format(name, options)
  end

  def self.validates_confirmation_of(name, options = {})
    validates_is_confirmed(name, options)
  end

  def self.validates_length_of(name, options = {})
    validates_length(name, options)
  end

  def role?( role )
    roles.collect(&:name).include? role.to_s
  end
  

 

end
