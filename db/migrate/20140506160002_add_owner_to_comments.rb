class AddOwnerToComments < ActiveRecord::Migration
  def change
    add_column :comments, :owner, :string
  end
end
