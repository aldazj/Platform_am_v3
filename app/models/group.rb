class Group < ActiveRecord::Base

    has_and_belongs_to_many :rights, :join_table => 'groups_rights'
    has_and_belongs_to_many :people, :join_table => 'groups_people'


    #Add right to group
    def add_right(right)
        rights << right
    end
end
