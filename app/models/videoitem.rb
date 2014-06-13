class Videoitem < ActiveRecord::Base

    #has_many :comments , :dependent => :destroy
    #accepts_nested_attributes_for :comments, :reject_if => lambda { |attribute| attribute[:message].blank?}, :allow_destroy => true

    has_many :assets , :dependent => :destroy
    accepts_nested_attributes_for :assets, :allow_destroy => true

    belongs_to :person

end
