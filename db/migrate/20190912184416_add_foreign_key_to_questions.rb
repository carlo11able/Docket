class AddForeignKeyToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :photo_id, :integer
    add_foreign_key :questions, :photos
  end
end
