class AddIndexToAnswerQuestionId < ActiveRecord::Migration[6.1]
  def change
    add_index :answers, :question_id
  end
end
