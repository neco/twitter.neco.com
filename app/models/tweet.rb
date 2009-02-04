class Tweet < ActiveRecord::Base
  belongs_to :twitter_user
  named_scope :from_twitter, :conditions => 'tweet_id IS NOT NULL'
  named_scope :from_local, :conditions => 'tweet_id IS NULL'
end
