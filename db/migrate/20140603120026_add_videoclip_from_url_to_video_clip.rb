class AddVideoclipFromUrlToVideoClip < ActiveRecord::Migration
  def change
    add_column :video_clips, :videoclip_from_url, :string
  end
end
