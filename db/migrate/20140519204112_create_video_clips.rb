class CreateVideoClips < ActiveRecord::Migration
  def change
    create_table :video_clips do |t|
      t.string :title
      t.string :description
      t.boolean :is_available
      t.date :date
      t.integer :views

      t.timestamps
    end
  end
end
