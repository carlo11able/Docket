class RemoveCorrectToPhotos < ActiveRecord::Migration[5.1]
  def change
    remove_column :photos, :correct, :integer
  end
end
