# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: '123456789',
    password_confirmation: '123456789'
  )
end

5.times do
  Category.create(
    rekognition_name: Faker::Creature::Animal.name,
    display_name: Faker::Creature::Animal.name,
  )
end

5.times do |index|
  article = Article.create!(
    user: User.offset(rand(User.count)).first,
    category: Category.offset(rand(Category.count)).first,
    title: "タイトル#{index}",
    description: "本文#{index}",
    image:File.open("app/assets/images/sample_image.jpeg"),
  )
end
