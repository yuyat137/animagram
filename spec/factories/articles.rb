# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  description :text
#  image       :string
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "タイトル#{n}" }
    image { File.open(File.join(Rails.root, 'spec/fixtures/test_image.jpeg')) }
    #image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_image.jpeg')}
    description { "content" }
    user
  end
end
