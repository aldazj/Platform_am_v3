module VideoClipsHelper

  def thumbnail_selected?(thumbnail)
    @thumbnail = Thumbnail.find(thumbnail)
    return @thumbnail.main_thumbnail
  end

end
