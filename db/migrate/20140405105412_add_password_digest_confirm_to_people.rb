class AddPasswordDigestConfirmToPeople < ActiveRecord::Migration
  def change
    add_column :people, :password_digest_confirm, :string
  end
end
