# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string
#  email            :string           not null
#  name             :string           not null
#  salt             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :comments, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_articles, through: :favorites, source: :article

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, uniqueness: true, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validate :password_complexity

  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/

    errors.add :password, 'パスワードの強度が不足しています。パスワードの長さは8〜70文字とし、大文字と小文字と数字と特殊文字をそれぞれ1文字以上含める必要があります。'
  end

  def own?(object)
    id == object.user_id
  end

  def favorite(article)
    favorites.create(article_id: article.id)
  end

  def unfavorite(article)
    favorites.find_by(article_id: article.id).destroy
  end

  def favorite?(article)
    favorite_articles.include?(article)
  end
end
