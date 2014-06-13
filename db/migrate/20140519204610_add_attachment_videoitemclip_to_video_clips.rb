class AddAttachmentVideoitemclipToVideoClips < ActiveRecord::Migration
  def self.up
    change_table :video_clips do |t|
      t.attachment :videoitemclip
    end
  end

  def self.down
    drop_attached_file :video_clips, :videoitemclip
  end
end
