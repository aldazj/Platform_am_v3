class AddPersonIdToVideoClip < ActiveRecord::Migration
  def change
    add_reference :video_clips, :person, index: true
  end
end
