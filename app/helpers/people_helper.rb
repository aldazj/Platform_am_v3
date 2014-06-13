module PeopleHelper

    def group_present?(group)
        !(@person.groups.find_by_id(group).nil?)
    end

    def personal_right_present?(right)
        @personalGroup = Personalgroup.find_by_id(@person.personalgroup)
        !(@personalGroup.rights.find_by_id(right).nil?)
    end

#    def person_type_include?(type)
#        @person.type.include?(type)
#    end
end
