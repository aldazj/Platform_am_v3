class AddMainThumbnailToThumbnail < ActiveRecord::Migration
  def change
    add_column :thumbnails, :main_thumbnail, :boolean
  end
end
