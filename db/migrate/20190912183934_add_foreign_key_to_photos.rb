class AddForeignKeyToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :user_id, :integer
    add_foreign_key :photos, :users
  end
end
