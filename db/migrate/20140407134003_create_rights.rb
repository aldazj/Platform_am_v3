class CreateRights < ActiveRecord::Migration
  def change
    create_table :rights do |t|
      t.string :name
      t.boolean :is_available

      t.timestamps
    end
  end
end
