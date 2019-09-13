class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    
    def facebook
        # You need to implement the method below in your model (e.g. app/models/user.rb)
        @user = User.from_omniauth(request.env["omniauth.auth"])
        if @user.persisted?
            sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
            set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
        else
            session["devise.facebook_data"] = request.env["omniauth.auth"]
            redirect_to new_user_registration_url
        end
    end
    
    def failure
        redirect_to ("/")
    end

    private
  
    # def set_default_role
    #   self.roles = [:user]
    # end
    
    def self.parse_name(user, name)
      name_arr = name.split(" ")
      user.surname = name_arr.pop
      user.name = name_arr.join(" ")
    end
  
    # def set_num_likes_dislikes
    #   self.num_likes = 0
    #   self.num_dislikes = 0
    # end

end