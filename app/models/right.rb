class Right < ActiveRecord::Base
    has_and_belongs_to_many :groups, :join_table => 'groups_rights'
    has_and_belongs_to_many :personalgroups, :join_table => 'personal_groupsrights'
end
