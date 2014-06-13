class CreatePersonalgroups < ActiveRecord::Migration
  def change
    create_table :personalgroups do |t|
      t.references :person, index: true

      t.timestamps
    end
  end
end
