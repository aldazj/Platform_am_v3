class AddRememberTokenToPeople < ActiveRecord::Migration
  def change
    add_column :people, :remember_token, :string
  end
end
