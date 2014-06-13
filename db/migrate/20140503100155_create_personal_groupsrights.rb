class CreatePersonalGroupsrights < ActiveRecord::Migration
  def change
    create_table :personal_groupsrights do |t|
      t.references :personalgroup, index: true
      t.references :right, index: true
    end
  end
end
