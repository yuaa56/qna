class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :question, null:false, foreign_key: true, index: true
      t.belongs_to :user, null:false, foreign_key: true, index: true
      t.timestamps null: false
    end

    add_index :subscriptions, [:user_id, :question_id], unique: true
  end
end
