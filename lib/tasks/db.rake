namespace :db do
  desc "Populates the database with users, lists, and items"
  task prepare: :environment do
    require 'faker'

    Rake::Task['db:reset'].invoke

      # Create Users
      5.times do 
        user = User.create!(
          username: Faker::Internet.user_name,
          password: Faker::Lorem.characters(8)
          )
      end
      users = User.all

      # Create Lists
      10.times do 
        list = List.new(
          user: users.sample,
          name: Faker::Lorem.words
          )
        list.save(validate: false)
      end
      lists = List.all

      # Create Items
      15.times do 
        item = Item.create!(
          list: lists.sample,
          name: Faker::Lorem.words
          )
      end
    puts "#{User.count} users created"
    puts "#{List.count} lists created"
    puts "#{Item.count} items created"
  end
end