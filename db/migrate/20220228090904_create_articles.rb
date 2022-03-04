class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :description
      t.string :image, null: false
      t.references :user, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
