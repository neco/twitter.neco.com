class Tweet < ActiveRecord::Base
  belongs_to :twitter_user
  
  named_scope :recent, :limit => 3, :order => 'tweets.tweeted_at desc', :include => :twitter_user
end
