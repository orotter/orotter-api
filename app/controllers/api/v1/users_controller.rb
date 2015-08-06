module Api::V1
  class UsersController < ApiController
    def search
      keyword = params[:keyword].presence || ""
      @users = User.where('name LIKE ? or username LIKE ?', "%#{keyword}%", "%#{keyword}%")
      render :json => @users
    end
    
    def follows
      render :json => current_user.follows
    end
    
    def followers
      render :json => current_user.followers
    end
    
    def follow
      if !current_user.follows.exists?(:id => params[:id])
        Follow.create(:from_user_id => current_user.id, :to_user_id => params[:id])
      end
      render :json => current_user
    end
    
    def unfollow
      Follow.destroy_all(:from_user_id => current_user.id, :to_user_id => params[:id])
      render :json => current_user
    end
  end
end
