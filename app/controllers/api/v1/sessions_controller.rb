module Api::V1
  class SessionsController < ApiController
    skip_before_action :authenticate_user
    def login
      @user = User.find_by_username(params[:username])
      if @user == nil || !@user.valid_password?(params[:password]) || !sign_in(:user, @user)
        throw "ユーザー名またはパスワードが違います"
      end
      render :json => {
        :user => @user
      }
    end
    
    def logout
      sign_out(current_user)
      render :json => {
        :result => true
      }
    end
    
    def signup
      @user = User.new({
        :username => params[:username],
        :name     => params[:name],
        :image    => params[:image],
        :password => params[:password]
      })
      @user.save!
      sign_in(:user, @user)
      render :json => {
        :user => @user
      }
    end
  end
end
