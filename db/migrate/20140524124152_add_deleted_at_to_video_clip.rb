class AddDeletedAtToVideoClip < ActiveRecord::Migration
  def change
    add_column :video_clips, :deleted_at, :datetime
    add_index :video_clips, :deleted_at
  end
end
