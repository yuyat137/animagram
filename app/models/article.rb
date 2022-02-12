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
  has_one_attached :image
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 300 }
  validates :image, presence: true
  validate :image_type, :image_size

  private

    def image_type
      return if image.blob.content_type.in?(%('image/jpeg image/png'))

      image.purge
      image.add(:image, 'はjpegまたはpng形式でアップロードしてください')
    end

    def image_size
      return unless image.blob.byte_size > 5.megabytes

      image.purge
      errors.add(:image, 'は1つのファイル5MB以内にしてください')
    end
end
