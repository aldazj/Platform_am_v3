class CreateFormatvideos < ActiveRecord::Migration
  def change
    create_table :formatvideos do |t|
      t.references :videoClip, index: true

      t.timestamps
    end
  end
end
