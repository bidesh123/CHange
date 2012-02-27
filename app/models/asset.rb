#require 'will_paginate'
require "#{Rails.root}/vendor/gems/will_paginate/lib/will_paginate/finders/data_mapper.rb"
class Asset
  cattr_reader :per_page
  @@per_page = 2
  include DataMapper::Resource
  include DataMapper::MassAssignmentSecurity
  has n, :orders, :through => :line_items
  has n, :line_items

  property :id, Serial

  property :assetable_id, Integer
  property :assetable_type, String
  property :price, Integer
  validates_numericality_of :price
  belongs_to :store
end
