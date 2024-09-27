# db/seeds.rb

require 'faker'

# Create 100 users with random Discord usernames
5.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: 'password',  # You can use a common password for testing
    discord_username: "#{Faker::Internet.username}##{rand(1000..9999)}"
  )

  # Each user has between 1 and 5 posts
  rand(1..5).times do
    Post.create!(
      content: Faker::Lorem.sentence(word_count: rand(5..15)),
      user: user
    )
  end
end
