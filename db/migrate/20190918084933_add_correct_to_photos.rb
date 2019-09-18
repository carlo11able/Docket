class AddCorrectToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :correct, :integer
  end
end
