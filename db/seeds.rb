# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(
  name: "Example User",
  email: "example@railstutorial.org",
  password: "foobar",
  password_confirmation: "foobar",
  admin: true,
)

19.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
  )
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each{|followed| user.follow(followed)}
followers.each{|follower| follower.follow(user)}

#Categories
Category.create!(title: "Example Category",
  description: "- Always think how to improve the current code and design more\n
    - Do not asks basic questions\n
    - Do not ask the same a problem many times\n
    - Researches to resolve problems by himself\n
    - Discusses with others in team\n
    - Gives actively the idea about problems in team\n
    - Discusses in lectures\n
    - Ask leader about complex task\n
    - Support others\n
    - Comment on GitHub.")

19.times do
  title = Faker::Lorem.sentence
  description = Faker::Lorem.paragraph
  Category.create! title: title, description: description
end

#Words
categories = Category.all
categories.each do |category| 
  30.times do
    content = Faker::Lorem.word
    word = category.words.build content: content
    4.times do |n|
      content = Faker::Lorem.word
      correct = n == 0 ? true : false
      word.answers.build content: content, correct: correct
    end
    word.save!
  end
end

