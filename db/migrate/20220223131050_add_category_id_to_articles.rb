class AddCategoryIdToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :category_id, :integer, foreign_key: true, null: false
  end
end
