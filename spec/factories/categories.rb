# == Schema Information
#
# Table name: categories
#
#  id               :bigint           not null, primary key
#  display_name     :string           not null
#  rekognition_name :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_categories_on_display_name      (display_name) UNIQUE
#  index_categories_on_rekognition_name  (rekognition_name) UNIQUE
#
FactoryBot.define do
  factory :category do
    sequence(:rekognition_name) { |n| "rekognition_name-#{n}" }
    sequence(:display_name) { |n| "display_name-#{n}" }
  end
end
