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
    end

    def new
    end

    def create 
    end

    def edit     
    end

    def update
    end
  
    def destroy
    end
end