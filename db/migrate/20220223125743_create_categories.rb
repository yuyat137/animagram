class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :rekognition_name, null: false, index: { unique: true }
      t.string :display_name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
