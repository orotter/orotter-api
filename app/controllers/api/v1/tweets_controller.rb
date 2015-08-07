module Api::V1
  class TweetsController < ApiController
    def index
        render :json => current_user.tweets
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
