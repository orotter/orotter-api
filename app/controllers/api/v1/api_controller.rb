module Api::V1
  class ApiController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    before_action :authenticate_user
    
    def authenticate_user
      return if user_signed_in? 
      render :json => {
        :error => 'please login !!'
      }
    end
  end
end