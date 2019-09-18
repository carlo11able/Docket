class ErrorsController < ActionController::Base
    protect_from_forgery with: :null_session

    def internal_server_error
        #render "static/notfound", status: 404
        raise ActionController::RoutingError.new(params[:path])
    end
end