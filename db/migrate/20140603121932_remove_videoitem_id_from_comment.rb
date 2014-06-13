class RemoveVideoitemIdFromComment < ActiveRecord::Migration
  def change
    remove_column :comments, :videoitem_id, :integer
  end
end
