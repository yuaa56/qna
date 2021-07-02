class RemoveColumnStringAttachment < ActiveRecord::Migration[6.1]
  def change
    remove_column :attachments, :string
  end
end
