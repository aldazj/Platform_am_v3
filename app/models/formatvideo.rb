class Formatvideo < ActiveRecord::Base

  belongs_to :videoClip

  has_attached_file :format,
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :bucket => '**************',
                    :s3_host_name => 's3-us-west-2.amazonaws.com',
                    :path => ':class/:attachment/:id/:style/:basename.:extension'

  TYPES = %w( FormatFvl Formath264 FormatAvi )

  before_save :set_type
  validates :type, presence: true, :inclusion => { :in => TYPES }

  validates_attachment_presence :format

  validates_attachment_content_type :format,
                                    :content_type =>
                                        [ "application/x-mp4",
                                          "video/mpeg",
                                          "video/quicktime",
                                          "video/x-la-asf",
                                          "video/x-ms-asf",
                                          "video/x-msvideo",
                                          "video/x-sgi-movie",
                                          "video/x-flv",
                                          "flv-application/octet-stream",
                                          "video/3gpp",
                                          "video/3gpp2",
                                          "video/3gpp-tt",
                                          "video/BMPEG",
                                          "video/BT656",
                                          "video/CelB",
                                          "video/DV",
                                          "video/H261",
                                          "video/H263",
                                          "video/H263-1998",
                                          "video/H263-2000",
                                          "video/H264",
                                          "video/JPEG",
                                          "video/MJ2",
                                          "video/MP1S",
                                          "video/MP2P",
                                          "video/MP2T",
                                          "video/mp4",
                                          "video/MP4V-ES",
                                          "video/MPV",
                                          "video/mpeg4",
                                          "video/mpeg4-generic",
                                          "video/nv",
                                          "video/parityfec",
                                          "video/pointer",
                                          "video/raw",
                                          "video/rtx"]


  def set_type
    raiser "override method  in each model inheriting from Person!"
  end

end
