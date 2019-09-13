class AddAnswersToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :question_answer1, :text
    add_column :questions, :question_answer2, :text
  end
end
