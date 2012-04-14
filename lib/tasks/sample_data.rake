namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Ricardo Lopes",
                         email: "mail@ricardolopes.net",
                         password: "password",
                         password_confirmation: "password")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@example.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 6)
    50.times do
      description = Faker::Lorem.sentence(5)
      users.each { |user| user.klinks.create!(description: description) }
    end
  end
end