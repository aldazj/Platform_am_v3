class AddVideoClipIdToFormatvideo < ActiveRecord::Migration
  def change
    add_reference :formatvideos, :video_clip, index: true
  end
end
