class TweetsController < ApplicationController
  def index
    search_opts = params[:search] || {}
    search_opts[:per_page] ||= 100
    search_opts[:order_by] = :tweeted_at
    search_opts[:order_as] = 'DESC'
    @search = Tweet.new_search(search_opts)
    @tweets, @tweets_count = @search.all, @search.count
  end
  
  def post
  end
  
  def forget_me
    session[:twitter_username] = nil
    session[:twitter_password] = nil
    redirect_to :action => 'post'
  end
  
  def create_tweet
    username, password, message = params[:username], params[:password], params[:message]
    
    if session[:twitter_username] && session[:twitter_password]
      username, password = session[:twitter_username], session[:twitter_password]
    end
    
    twitter = Twitter.new(username, password)
    begin
      twitter.post(message)
      twitter_user = TwitterUser.find_by_screen_name(username)
      twitter_user.tweets.create :tweeted_at => Time.now, :tweet_text => message
      
      # only remember if post was successful
      if params[:remember]
        session[:twitter_username] = username
        session[:twitter_password] = password
      end
      
      redirect_to :action => 'index'
    rescue
      @error = 'Bad username or password.'
      render :action => 'post'
    end
  end
end