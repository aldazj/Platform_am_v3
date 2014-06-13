class AddTypeToFormatvideo < ActiveRecord::Migration
  def change
    add_column :formatvideos, :type, :string
  end
end
