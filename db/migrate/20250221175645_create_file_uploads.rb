class CreateFileUploads < ActiveRecord::Migration[7.2]
  def change
    create_table :file_uploads do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
