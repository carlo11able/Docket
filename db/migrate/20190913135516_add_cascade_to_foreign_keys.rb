class AddCascadeToForeignKeys < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :photos, :users
    add_foreign_key :photos, :users, on_delete: :cascade

    remove_foreign_key :questions, :photos
    add_foreign_key :questions, :photos, on_delete: :cascade

  end
end
