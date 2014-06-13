class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :message
      t.boolean :is_available
      t.date :date
      t.string :url
      t.references :videoitem, index: true

      t.timestamps
    end
  end
end
