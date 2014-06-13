class CreateGroupsPeople < ActiveRecord::Migration
  def change
    create_table :groups_people do |t|
      t.references :group, index: true
      t.references :person, index: true
    end
  end
end
