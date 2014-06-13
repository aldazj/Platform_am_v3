class CreateGroupsRights < ActiveRecord::Migration
  def change
    create_table :groups_rights do |t|
      t.references :group, index: true
      t.references :right, index: true
    end
  end
end
