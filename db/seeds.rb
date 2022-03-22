# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "管理者",
             email: "admin@example.jp",
             password:  "Password-222",
             password_confirmation: "Password-222",
             role: 1)

10.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'Password-222',
    password_confirmation: 'Password-222'
  )
end

Category.create!(
  [
    {
      rekognition_name: 'Cat',
      display_name: '猫'
    },
    {
      rekognition_name: 'Dog',
      display_name: '犬'
    },
    {
      rekognition_name: 'Rabbit',
      display_name: 'うさぎ'
    },
    {
      rekognition_name: 'Hamster',
      display_name: 'ハムスター'
    },
    {
      rekognition_name: 'Parakeet',
      display_name: 'インコ'
    },
    {
      rekognition_name: 'Otter',
      display_name: 'カワウソ'
    },
    {
      rekognition_name: 'Ferret',
      display_name: 'フェレット'
    },
    {
      rekognition_name: 'Hedgehog',
      display_name: 'ハリネズミ'
    },
    {
      rekognition_name: 'Chinchilla',
      display_name: 'チンチラ'
    },
    {
      rekognition_name: 'Owl',
      display_name: 'フクロウ'
    },
    {
      rekognition_name: 'Penguin',
      display_name: 'ペンギン'
    },
    {
      rekognition_name: 'Flying squirrel',
      display_name: 'モモンガ'
    },
    {
      rekognition_name: 'Capybara',
      display_name: 'カピパラ'
    },
    {
      rekognition_name: 'Gecko',
      display_name: 'トカゲ'
    },
    {
      rekognition_name: 'Reptile',
      display_name: '爬虫類'
    },
    {
      rekognition_name: 'Bird',
      display_name: '鳥類'
    },
    {
      rekognition_name: 'Fish',
      display_name: '魚類'
    },
    {
      rekognition_name: 'その他',
      display_name: 'その他'
    }
  ]
)

5.times do |index|
  article = Article.create!(
    user: User.offset(rand(User.count)).first,
    category: Category.offset(rand(Category.count)).first,
    title: "タイトル#{index}",
    description: "本文#{index}",
    image:File.open("app/assets/images/sample_image.jpeg"),
  )
end
