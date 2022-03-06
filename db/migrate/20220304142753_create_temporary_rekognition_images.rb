class CreateTemporaryRekognitionImages < ActiveRecord::Migration[6.1]
  def change
    create_table :temporary_rekognition_images do |t|
      t.string :source, null: false

      t.timestamps
    end
  end
end
