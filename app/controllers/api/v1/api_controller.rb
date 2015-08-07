module Api::V1
  class ApiController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    #protect_from_forgery with: :null_session
    before_action :authenticate_user
    # rescue_from Exception, with: :render_error
    # rescue_from ::Errors::UnauthorizedError, with: :render_unauthorized
    
    def authenticate_user
      return if user_signed_in?
      render :json => {
        :error   => "Please login"
      }, :status => :unauthorized
    end
    
  end
end