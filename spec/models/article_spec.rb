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
require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do
      article = build(:article)
      expect(article).to be_valid
      expect(article.errors).to be_empty
    end

    it 'is invalid without title' do
      article_without_title = build(:article, title: "")
      expect(article_without_title).to be_invalid
      expect(article_without_title.errors[:title]).to_eq ["can't be blank"]
    end
  end
end
