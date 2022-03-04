# == Schema Information
#
# Table name: temporary_rekognition_images
#
#  id         :bigint           not null, primary key
#  source     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TemporaryRekognitionImage < ApplicationRecord
  mount_uploader :source, ImageUploader
end
