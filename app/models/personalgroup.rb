class Personalgroup < ActiveRecord::Base

  belongs_to :person
  has_and_belongs_to_many :rights, :join_table => 'personal_groupsrights'

  #Add right to personalgroup
  def add_right_to_personalgroup(right)
      self.rights << right
  end
end
