require 'httparty'

class Twitter
  include HTTParty
  base_uri 'twitter.com'
  
  def initialize(u=nil, p=nil)
    @auth = {:username => u, :password => p} unless u.nil? || p.nil?
  end
  
  # which can be :friends, :user or :public
  # options[:query] can be things like since, since_id, count, etc.
  def timeline(which=:friends, options={})
    options.merge!({:basic_auth => @auth}) if @auth
    self.class.get("/statuses/#{which}_timeline.json", options)
  end
  
end