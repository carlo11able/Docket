class AddConstraintToQuestions < ActiveRecord::Migration[5.1]
  def change
    change_column_null :questions, :question_text, false
    change_column_null :questions, :question_answer1, false
    change_column_null :questions, :question_answer2, false
  end
end
