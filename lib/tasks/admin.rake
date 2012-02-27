require 'rake'
namespace :admin_create do
  desc "Create one Admin User"
  task :create => :environment  do
    require "#{Rails.root}/lib/setup"
    Lostbets::Setup.bootstrap(
      :admin_firstname => ENV['ADMIN_FIRSTNAME'],
      :admin_lastname => ENV['ADMIN_LASTNAME'],

      :admin_email => ENV['ADMIN_EMAIL'],
      :admin_username => ENV['ADMIN_USERNAME'],
      :admin_password => ENV['ADMIN_PASSWORD']

    )



  end
end