class CreateAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :attachments do |t|
      t.string :file
      t.string :string

      t.timestamps
    end
  end
end
