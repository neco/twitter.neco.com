module TweetsHelper
  def parse_tweet(txt)
    txt.gsub(%r((http|https)://[^<>\s]+), %[<a href="\\0" target="_blank">\\0</a>])
  end
  
  def remembered?
    session[:twitter_username] && session[:twitter_password]
  end
end