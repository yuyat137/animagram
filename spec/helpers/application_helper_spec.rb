require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#full_title(page_title)' do
    subject { full_title(page_title) }

    context 'page_titleが空白の場合' do
      let(:page_title) { '' }
      it '動的な表示がなされること' do
        expect(full_title(nil)).to eq('animagram')
      end
    end

    context 'page_titleがnilの場合' do
      let(:page_title) { nil }
      it '動的な表示がなされること' do
        expect(full_title('')).to eq('animagram')
      end
    end

    context 'page_titleが存在する場合' do
      let(:page_title) { 'sample' }
      it 'page_title | animagramと動的な表示がなされること' do
        expect(full_title('sample')).to eq('sample | animagram')
      end
    end
  end
end
