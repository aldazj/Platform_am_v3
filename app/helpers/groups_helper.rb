module GroupsHelper

    def right_present?(right)
        !(@group.rights.find_by_id(right).nil?)
    end


    def group_right_present?(group, right)
        @group = Group.find_by_id(group)
        !(@group.rights.find_by_id(right).nil?)
    end
end
