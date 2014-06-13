class AddVideoClipIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :video_clip_id, :integer
  end
end
