module SessionsHelper

    def sign_in(person)
        cookies.permanent[:remember_token] = person.remember_token
        self.current_person = person
        # Sets a cookie that expires in 1 hour.
        #cookies[:login] = { value: "XJ-122", expires: 1.hour.from_now }
    end

    def signed_in?
        !(current_person.nil?)
    end

    def sign_out
        self.current_person = nil
        cookies.delete(:remember_token)
    end

    def current_person=(person)
        @current_person = person
    end
    def current_person
        @current_person ||= Person.find_by_remember_token(cookies[:remember_token])
    end

    def current_person?(person)
        person == current_person
    end

    def signed_in_person
        unless signed_in?
            store_location
            redirect_to signin_path, notice: 'Please sign in.'
        end
    end

    def store_location
        session[:return_to] = request.url
    end


    def right_in_current_personalgroup?(right)
        @current_person ||= Person.find_by_remember_token(cookies[:remember_token])
        personalgroup = Personalgroup.find_by_person_id(@current_person.id)
        !(personalgroup.rights.find_by_name(right).nil?)
    end

    def right_in_current_person_personalgroup?(right)
        personalgroup = Personalgroup.find_by_person_id(current_person.id)
        !(personalgroup.rights.find_by_name(right).nil?)
    end

    def current_person_groups_enable?
        !(current_person.groups.nil?)
    end

    def right_in_current_person_groups?(right)
        available = false
        current_person.groups.each do |group|
            if group.rights.find_by_name(right)
                available = true
                return available
            end
        end
        return available
    end

    def current_person_is_video_owner?(video_clip_tmp)
        !(current_person.video_clips.find_by_id(video_clip_tmp.id).nil?)
    end

end
