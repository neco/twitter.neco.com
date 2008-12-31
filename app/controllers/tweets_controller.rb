class TweetsController < ApplicationController
  def index
    search_opts = params[:search] || {}
    search_opts[:per_page] ||= 10
    search_opts[:order_by] = :tweeted_at
    search_opts[:order_as] = 'DESC'
    @search = Tweet.new_search(search_opts)
    @tweets, @tweets_count = @search.all, @search.count
  end
end