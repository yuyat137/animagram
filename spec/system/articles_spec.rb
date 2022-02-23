require 'rails_helper'

RSpec.describe 'article', type: :system do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }

  describe 'articleの一覧ページ' do
    context 'ログインしていない場合' do
      it 'article作成リンクが表示されていないこと' do
        visit articles_path
        expect(page).not_to have_link('写真を投稿する')
      end
    end

    context 'ログインした場合' do
      it 'article作成リンクが表示されていること' do
        login_as(user)
        visit articles_path
        expect(page).to have_link('写真を投稿する')
      end
    end

    context '掲示板が一件もない場合' do
      it '何もない旨が表示されていること' do
        visit articles_path
        expect(page).to have_content('写真がありません')
      end
    end

    context 'articleがある場合' do
      it 'article一覧が表示されていること' do
        article
        visit articles_path
        expect(page).to have_content(article.title)
        expect(page).to have_content(article.description)
        expect(page).to have_content(article.user.name)
        expect(page).to have_selector("img[src$='something.jpg']")
      end
    end
  end

  describe 'articleの詳細画面' do
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        visit edit_article_path(article)
        expect(current_path).to eq('/login')
        have_content 'ログインしてください'
      end
    end

    context 'ログインしている場合' do
      before do
        article
        login_as(user)
      end
      it 'articleの詳細が表示されること' do
        visit articles_path
        click_on article.title
        expect(page).to have_content(article.title)
        expect(page).to have_content(article.description)
        expect(page).to have_content(article.user.name)
        expect(page).to have_selector("img[src$='something.jpg']")
      end
    end
  end

  describe 'articleの作成' do
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        visit new_article_path
        expect(current_path).to eq('/login')
        have_content 'ログインしてください'
      end
    end
  end
end