class CreateThumbnails < ActiveRecord::Migration
  def change
    create_table :thumbnails do |t|
      t.references :videoClip, index: true

      t.timestamps
    end
  end
end
