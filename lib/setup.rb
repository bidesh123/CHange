require "highline/import"
require "forwardable"
module Lostbets
  #  include Gem::UserInteraction
  class Setup

    class << self
      def bootstrap(config)
        setup = new
        setup.bootstrap(config)
        setup
      end
    end

    attr_accessor :config

    def bootstrap(config)
      @config = config
      @admin = create_admin_user(config[:admin_email], config[:admin_username], config[:admin_password], config[:firstname],config[:lastname])
    end

    def create_admin_user(email, username, password,firstname,lastname)
      unless email and username and password
        #        announce "Create the admin user (press enter for defaults)."
        firstname= prompt_for_admin_firstname unless firstname
        lastname= prompt_for_admin_lastname unless lastname
        email = prompt_for_admin_email unless email
        username = prompt_for_admin_username unless username
        password = prompt_for_admin_password unless password
      end
      attributes = {
        :first_name => firstname,
        :last_name => lastname,
        :username => username,
        :password => password,
        :password_confirmation => password,
        :email => email
      }
      admin = User.first(:username => username)
      admin = User.new(attributes) unless admin
      admin.skip_confirmation!
      admin.roles << Role.first(:name => "admin")
      admin.save
      admin
    end

    def prompt_for_admin_firstname
      firstname = ask('First Name: ', String) do |q|
        q.validate = /^.{0,100}$/
        q.responses[:not_valid] = "Invalid name. Must be at less than 100 characters long."
        q.whitespace = :strip
      end
      firstname = "Admin" if firstname.blank?
      firstname
    end

    def prompt_for_admin_lastname
      lastname = ask('Last Name: ', String) do |q|
        q.validate = /^.{0,100}$/
        q.responses[:not_valid] = "Invalid name. Must be at less than 100 characters long."
        q.whitespace = :strip
      end
      lastname = "Admin" if lastname.blank?
      lastname
    end

    def prompt_for_admin_email
      email = ask('Email: ', String) do |q|
        q.validate = /^.{0,100}$/
        q.responses[:not_valid] = "Invalid name. Must be at less than 100 characters long."
        q.whitespace = :strip
      end
      email = "admin@lostbets.com" if email.blank?
      email
    end

    def prompt_for_admin_username
      username =  ask('Username: ', String) do |q|
        q.validate = /^(|.{3,40})$/
        q.responses[:not_valid] = "Invalid username. Must be at least 3 characters long."
        q.whitespace = :strip
      end
      username = "admin" if username.blank?
      username
    end

    def prompt_for_admin_password
      password =  ask('Password: ', String) do |q|
        q.echo = false unless defined?(::JRuby) # JRuby doesn't support stty interaction
        q.validate = /^(|.{5,40})$/
        q.responses[:not_valid] = "Invalid password. Must be at least 5 characters long."
        q.whitespace = :strip
      end
      password = "lostbets" if password.blank?
      password
    end
  end
end