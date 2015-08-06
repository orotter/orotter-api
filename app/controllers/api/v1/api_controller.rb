module Api::V1
  class ApiController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    before_action :authenticate_user
    before_filter :allow_cross_domain_access
    
    def allow_cross_domain_access
      response.headers["Access-Control-Allow-Origin"] = "*"
      response.headers["Access-Control-Allow-Methods"] = "*"
    end
    
    def authenticate_user
      return if user_signed_in? 
      render :json => {
        :error => 'please login !!'
      }
    end
  end
end