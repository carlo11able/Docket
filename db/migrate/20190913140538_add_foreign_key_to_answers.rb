class AddForeignKeyToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :question_id, :integer
    add_foreign_key :answers, :questions, on_delete: :cascade

    add_column :answers, :user_id, :integer
    add_foreign_key :answers, :users, on_delete: :cascade
  end
end
