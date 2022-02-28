# frozen_string_literal: true

# == Schema Information
#
# Table name: favorites
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :user_id, uniqueness: { scope: :article_id }
end
