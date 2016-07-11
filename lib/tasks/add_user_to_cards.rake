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

    cards_without_user = Card.where("user_id is NULL")
    if cards_without_user
      cards_without_user.each { |card| card.user_id = user.id }
    end
  end

  desc "Copy and encrypt password to crypted_password for all users"
  task :encrypt_password => :environment do
    users = User.all
    users.each do |user|
      user.crypted_password = BCrypt::Password.create(user.password)
      user.save
    end
  end

end
