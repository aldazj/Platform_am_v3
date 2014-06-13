class RemoveOwnerFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :owner, :string
  end
end
