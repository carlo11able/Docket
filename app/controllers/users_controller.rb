class UsersController < ApplicationController

    #protect_from_forgery with: :null_session        #annulla CSRF token authentication
    before_action :authenticate_user!


    
    def smistamento
        
        if(current_user.has_role? :admin)
            redirect_to users_path
        end

        if(current_user.has_role? :customer)
            redirect_to photos_path
        end

        if(current_user.has_role? :labeler)
            redirect_to answers_path
        end

    end


    def customers
        begin
            authorize! :manage, User, :message => "BEWARE: You are not authorized to read a photo."
        rescue CanCan::AccessDenied
            #render html: "ACCESSO NEGATO" , status: 403
            render "static/accessdenied" , status: 403
        end
        @customers=User.where(roles_mask: 4)
    end

    def labelers
        begin
            authorize! :manage, User, :message => "BEWARE: You are not authorized to read a photo."
        rescue CanCan::AccessDenied
            #render html: "ACCESSO NEGATO" , status: 403
            render "static/accessdenied" , status: 403
        end
        @labelers=User.where(roles_mask: 2)
    end
    
    
    def index
        begin
            authorize! :read, current_user, :message => "BEWARE: You are not authorized to read a photo."
        rescue CanCan::AccessDenied
            #render html: "ACCESSO NEGATO" , status: 403
            render "static/accessdenied" , status: 403
        end
        @users=User.all()
        #render :html => "prova"
    end
    

    def show
        begin
            id = params[:id] # retrieve user ID from URI route
            @user=User.find(id)
            begin
                authorize! :read, @user, :message => "BEWARE: You are not authorized to read a photo."
            rescue CanCan::AccessDenied
                render "static/accessdenied" , status: 403
            end
        rescue ActiveRecord::RecordNotFound 
            # redirect_to :controller => "users", :action => "index"
            render "static/notfound"
            flash[:warning] = "There is no user with that index"
            return
        end
        # will render app/views/users/show.html.erb by default
    end


   


    def edit
        begin
            id = params[:id] # retrieve user ID from URI route
            @user=User.find(id)
            begin
                authorize! :update, @user, :message => "BEWARE: You are not authorized to read a photo."
            rescue CanCan::AccessDenied
                #render html: "ACCESSO NEGATO" , status: 403
                render "static/accessdenied" , status: 403
            end
        rescue ActiveRecord::RecordNotFound 
            redirect_to :controller => "user", :action => "index"
            flash[:warning] = "There is no user with that index"
            return
        end
        redirect_to edit_user_registration_path
        
    end

    # def update
    #     @user = User.find params[:id]
    #     # authorize! :update, @user, :message => "BEWARE: You are not authorized to update a user."
    #     # if current_user != @user.user
    #     #     flash[:warning] = "You are not authorized to update this user"
    #     #     redirect_to user_path(@user)
    #     # end
    #     # @user.update_attributes!(params[:user].permit(:name, :street, :address, :city, :telephone_number, :opening_time, :closing_time, :description, :notices, :icon))
    #     # respond_to do |client_wants|
    #     #     client_wants.html {
    #     #         flash[:notice] = "#{@user.name} was successfully updated."
    #     #         redirect_to user_path(@user)
    #     #     }
    #     #     client_wants.xml { render :xml => @user.to_xml }
    #     # end
    #     @user.update_attributes!(user_params_update)
    #     redirect_to user_path(@user)
    
    # end

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

    private 

    def user_params_create
        params[:user].permit(:name, :surname, :email, :password, :password_confirmation)
    end
    
    def user_params_update
        params[:place].permit(:name, :surname, :email, :password, :password_confirmation)
    end


end