class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?


     rescue_from ActionController::RoutingError do |exception|
          logger.error 'Routing error occurred'
          render 'static/notfound', status: 404
     end

     protected
          def after_sign_in_path_for(resource)
               "/home"
          end

          def configure_permitted_parameters
               devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :surname, :email, :password, :password_confirmation, :roles_mask)}
               devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :surname, :email, :password, :password_confirmation, :current_password)}
          end
end
