class AddTokenToVideoClip < ActiveRecord::Migration
  def change
    add_column :video_clips, :token, :string
  end
end
