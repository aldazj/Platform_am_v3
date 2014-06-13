class Comment < ActiveRecord::Base
  #belongs_to :videoitem
  belongs_to :person
  belongs_to :video_clip
end
