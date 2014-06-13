include SessionsHelper

class SessionsController < ApplicationController

    def new
        if signed_in?
            #redirect_to videoitems_path
          redirect_to video_clips_path
        else
            render 'new'
        end
    end

    def create
       person = Person.find_by_email(params[:session][:email])
       if person && person.authenticate(params[:session][:password])
           sign_in person
           #redirect_to videoitems_path
           redirect_to video_clips_path
       else
           flash.now[:error] = 'Invalid email or password'
           render 'new'
       end

    end

    def destroy
        sign_out
        redirect_to signin_path
    end
end
