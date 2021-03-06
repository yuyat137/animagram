# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string
#  email            :string           not null
#  name             :string           not null
#  role             :integer          default(0), not null
#  salt             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'name、email、passwordがあり、パスワードが8〜70文字、大文字と小文字と数字と特殊文字をそれぞれ1文字以上含まれている場合' do
    it '有効であること' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end
  end

  it 'email、name、password、password_confirmationは必須項目であること' do
    user = build(:user)
    user.name = nil
    user.email = nil
    user.password = nil
    user.password_confirmation = nil
    user.valid?
    expect(user.errors[:name])
    expect(user.errors[:email])
    expect(user.errors[:password])
    expect(user.errors[:password_confirmation])
  end

  context 'nameが50文字以下である場合' do
    it '有効であること' do
      user = build(:user, name: 'a' * 50)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end
  end

  context 'nameが51文字以上である場合' do
    it '無効であること' do
      user = build(:user, name: 'a' * 51)
      expect(user).to be_invalid
      expect(user.errors[:name])
    end
  end

  context 'emailがユニークでない場合' do
    it '無効であること' do
      user1 = create(:user)
      user2 = build(:user)
      user2.email = user1.email
      user2.valid?
      expect(user2.errors[:email])
    end
  end

  context 'passwordが8文字未満の場合' do
    it '無効であること' do
      user = build(:user, password: 'Psw-000')
      expect(user).to be_invalid
      expect(user.errors[:password])
    end
  end
end
