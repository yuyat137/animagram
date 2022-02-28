# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  description :text
#  image       :string           not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  user_id     :bigint
#
# Indexes
#
#  index_articles_on_category_id  (category_id)
#  index_articles_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
class Article < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_articles, through: :favorites, source: :article

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 300 }
  validates :image, presence: true
end
