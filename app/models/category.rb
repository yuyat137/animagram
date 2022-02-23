# frozen_string_literal: true

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
class Category < ApplicationRecord
  has_many :articles, dependent: :destroy

  validates :rekognition_name, uniqueness: true, presence: true
  validates :display_name, uniqueness: true, presence: true
end
