class CreateVideoitems < ActiveRecord::Migration
  def change
    create_table :videoitems do |t|
      t.string :title
      t.string :description
      t.boolean :is_available
      t.date :date
      t.integer :views
      t.string :pathvideo

      t.timestamps
    end
  end
end
