# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  description :text
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
class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_articles, through: :favorites, source: :article

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 300 }
  validates :image, presence: true
  validate :image_type, :image_size

  private

    def image_type
      return if image.blob.content_type.in?(%('image/jpeg image/png'))

      errors.add(:image, 'はjpegまたはpng形式でアップロードしてください')
    end

    def image_size
      return unless image.blob.byte_size > 5.megabytes

      errors.add(:image, 'は1つのファイル5MB以内にしてください')
    end
end
