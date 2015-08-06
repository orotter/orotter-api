module Api::V1
  class TweetsController < ApiController
    
    def index
        render :json => current_user.tweets
    end
    
    def create
      @tweet = current_user.tweets.create(:text => params[:text])
      render :json => @tweet
    end
  end
end
