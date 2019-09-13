class UsersController < ApplicationController

    #protect_from_forgery with: :null_session        #annulla CSRF token authentication
    before_action :authenticate_user!

    #acts_as_user :roles => [ :labeler, :customer, :admin ]

    #skip_before_action :verify_authenticity_token      #another way to deactivate CSRF token authentication

    def index
        @users=User.all()
        #render :html => "prova"
    end
    

    def show
        begin
            id = params[:id] # retrieve user ID from URI route
            @user=User.find(id)
            # @user = Place.find(id)
            # authorize! :read, @user, :message => "BEWARE: You are not authorized to read a user."
        rescue ActiveRecord::RecordNotFound 
            redirect_to :controller => "user", :action => "index"
            flash[:warning] = "There is no user with that index"
            return
        end
        # will render app/views/users/show.html.erb by default
    end

   


    def edit
        @user = User.find params[:id]
        # authorize! :update, @user, :message => "BEWARE: You are not authorized to edit a user."
        # if current_user != @user.user
        #     flash[:warning] = "You are not authorized to edit this user"
        #     redirect_to user_path(@user)
        # end
        
    end

    def update
        @user = User.find params[:id]
        # authorize! :update, @user, :message => "BEWARE: You are not authorized to update a user."
        # if current_user != @user.user
        #     flash[:warning] = "You are not authorized to update this user"
        #     redirect_to user_path(@user)
        # end
        # @user.update_attributes!(params[:user].permit(:name, :street, :address, :city, :telephone_number, :opening_time, :closing_time, :description, :notices, :icon))
        # respond_to do |client_wants|
        #     client_wants.html {
        #         flash[:notice] = "#{@user.name} was successfully updated."
        #         redirect_to user_path(@user)
        #     }
        #     client_wants.xml { render :xml => @user.to_xml }
        # end
        @user.update_attributes!(params[:user].permit(:url, :user_id))
        redirect_to user_path(@user)
    
    end

    def destroy
        @user = User.find(params[:id])
        # authorize! :destroy, @user, :message => "BEWARE: You are not authorized to delete a user."
        # if current_user != @user.user && !current_user.is?(:moderator) && !current_user.is?(:admin)
        #     flash[:warning] = "You are not authorized to delete this user"
        #     redirect_to user_path(@user)
        # end
        @user.destroy
        flash[:notice] = "User #{@user.id} deleted."
        redirect_to users_path
    end
end