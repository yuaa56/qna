class ChangeQuestionIdToAnswer < ActiveRecord::Migration[6.1]
  def change
    drop_table :answers
  end
end
