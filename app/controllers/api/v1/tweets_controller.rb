module Api::V1
  class TweetsController < ApiController
    def index
        @tweets = Tweet.where(:user_id => [current_user.id].concat(current_user.follows.pluck(:id))).order(:created_at => :desc).limit(100)
        render :json => @tweets
    end
    
    def index_for_user
      @tweets = Tweet.where(:user_id => params[:id]).order(:created_at => :desc).limit(100)
      render :json => @tweets
    end
    
    def create
      @tweet = current_user.tweets.create(:text => params[:text])
      render :json => @tweet
    end
  
    def favorite
      current_tweet.add_favorite_by(current_user)
      render :json => current_tweet
    end
    
    def unfavorite
      current_tweet.delete_favorite_by(current_user)
      render :json => current_tweet
    end
    
  private
    def current_tweet
      Tweet.find(params[:id])
    end
  end
end
