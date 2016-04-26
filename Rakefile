# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
#require 'config/environment'

Rails.application.load_tasks

namespace :flashcards do

  desc "Add user_id to ownerless cards, params: email=enter_email password=enter_password"
  task :add_user_to_cards => :environment do 
    email = ENV['email']
    password = ENV['password']

    if User.where("email = ?", email).first
      user = User.where("email = ?", email).first
      if password
        user.password = password
        puts "password is set for user with email: #{user.email}"
      end
    else
      user = User.create(email: email, password: password) 
      puts "user was created with email: #{user.email} and password: #{user.password}"
    end

    if cards_without_user = Card.where("user_id is NULL")
      cards_without_user.each { |card| card.user_id = user.id }
    end
  end

end
