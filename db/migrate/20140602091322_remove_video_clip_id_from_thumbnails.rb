class RemoveVideoClipIdFromThumbnails < ActiveRecord::Migration
  def change
    remove_column :thumbnails, :videoClip_id, :integer
  end
end
