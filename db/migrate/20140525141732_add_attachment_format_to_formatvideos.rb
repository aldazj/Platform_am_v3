class AddAttachmentFormatToFormatvideos < ActiveRecord::Migration
  def self.up
    change_table :formatvideos do |t|
      t.attachment :format
    end
  end

  def self.down
    drop_attached_file :formatvideos, :format
  end
end
