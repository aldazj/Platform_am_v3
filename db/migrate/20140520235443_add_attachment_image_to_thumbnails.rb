class AddAttachmentImageToThumbnails < ActiveRecord::Migration
  def self.up
    change_table :thumbnails do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :thumbnails, :image
  end
end
