class AddVideoClipIdToThumbnail < ActiveRecord::Migration
  def change
    add_reference :thumbnails, :video_clip, index: true
  end
end
