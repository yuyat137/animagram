# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  description :text
#  image       :string           not null
#  string      :string           not null
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
require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validation' do
    context 'すべての属性が有効な場合' do
      it '有効であること' do
        article = build(:article)
        expect(article).to be_valid
        expect(article.errors).to be_empty
      end
    end

    context 'titleが存在しない場合' do
      it '無効であること' do
        article_without_title = build(:article, title: '')
        expect(article_without_title).to be_invalid
        expect(article_without_title.errors[:title]).to eq ["can't be blank"]
      end
    end

    context 'titleが50字以下の場合' do
      it '有効であること' do
        article = build(:article, title: 'a' * 50)
        expect(article).to be_valid
        expect(article.errors).to be_empty
      end
    end

    context 'titleが51文字以上の場合' do
      it '無効であること' do
        article_over_title = build(:article, title: 'a' * 51 )
        expect(article_over_title).to be_invalid
        expect(article_over_title.errors[:title])
      end
    end

    context 'descriptionが300文字以下の場合' do
      it '有効であること' do
        article = build(:article, description: 'a' * 300 )
        expect(article).to be_valid
        expect(article.errors).to be_empty
      end
    end

    context 'descriptionが301文字以上の場合' do
      it '無効であること' do
        article = build(:article, description: 'a' * 301 )
        expect(article).to be_invalid
        expect(article.errors[:description])
      end
    end
  end
end
