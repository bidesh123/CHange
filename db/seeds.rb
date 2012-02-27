# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

['admin', "producer", "consumer"].each{ |role|
  @role = Role.first(:name => role)
  unless @role
    Role.create(:name => role)
  end
}

['Category1','Category2','Category3','Category4', 'Category5'].each{
  |cat|
  @cat=Category.first(:name => cat)
  unless @cat
    Category.create(:name => cat)
  end
}