require 'rails_helper'

RSpec.describe 'article', type: :system do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }

  describe 'articleの一覧ページ' do
    context 'ログインしていない場合' do
      it 'article作成リンクが表示されていないこと' do
        visit '/articles'
        expect(page).not_to have_link('写真を投稿する'), '未ログイン時に写真を投稿するリンクが表示されています'
      end
    end

    context 'ログインした場合' do
      it 'article作成リンクが表示されていること' do
        login_as(user)
        visit '/articles'
        expect(page).to have_link('写真を投稿する'), '未ログイン時に写真を投稿するリンクが表示されています'
      end
    end

    context '掲示板が一件もない場合' do
      it '何もない旨が表示されていること' do
        visit '/articles'
        expect(page).to have_content('写真がありません'), '掲示板が一件もない場合、「写真がありません」というメッセージが表示されていません'
      end
    end

    context 'articleがある場合' do
      it 'article一覧が表示されていること' do
        article
        visit '/articles'
        expect(page).to have_content(article.title), 'articleのtitleが表示されていません'
        expect(page).to have_content(article.description), 'articleのdescriptionが表示されていません'
        expect(page).to have_content(article.user.name), 'articleを作成したuserの名前が表示されていません'
        expect(page).to have_selector("img[src$='test_image.jpeg']")
        ("img[src$='test.jpg']")
      end
    end
  end
end