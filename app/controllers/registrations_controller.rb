class RegistrationsController < Devise::RegistrationsController

 

    def create
        super
        @parametro=params[:user]
        role=@parametro[:roles_mask]
        puts "AJHGFFGHJKKJHGGHJKL"
        puts role

             
        if(role=='labeler')
            puts "I am a labeler"
            @user.update(:roles_mask=>@user.roles_int([:labeler]))
           
        end

        if(role=='customer')
            puts "I am a customer"
            @user.update(:roles_mask=>@user.roles_int([:customer]))
        end

    end



    protected
    def after_sign_up_path_for(resource)
        "/home"
    end

    def after_inactive_sign_up_path_for(resource)
        "/home"
    end


    private 

    def user_params_create
        params[:user].permit(:name, :surname, :email, :password, :password_confirmation)
    end
    
    def user_params_update
        params[:place].permit(:name, :surname, :email, :password, :password_confirmation)
    end

  end 