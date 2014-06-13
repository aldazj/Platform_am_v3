class Thumbnail < ActiveRecord::Base
  belongs_to :videoClip


  has_attached_file :image,
                    :styles =>{:medium => '640x480>',
                               :thumb => '100x100#'
                               },
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :bucket => '**************',
                    :s3_host_name => 's3-us-west-2.amazonaws.com',
                    :path => ':class/:attachment/:id/:style/:basename.:extension'

  validates_attachment :image, presence: true, content_type: { content_type: ["image/png", "image/jpeg", "image/jpg", "image/gif"] }
  #validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ }
  after_initialize :init

  private

    def init
      if self.new_record? && self.main_thumbnail.nil?
        self.main_thumbnail = false
      end
    end
end
