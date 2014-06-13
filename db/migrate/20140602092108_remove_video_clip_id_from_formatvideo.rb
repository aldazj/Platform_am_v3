class RemoveVideoClipIdFromFormatvideo < ActiveRecord::Migration
  def change
    remove_column :formatvideos, :videoClip_id, :integer
  end
end
