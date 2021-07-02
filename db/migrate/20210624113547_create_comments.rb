class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string  :strComment
      t.integer :commentable_id
      t.string  :commentable_type
      t.timestamps
    end
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
