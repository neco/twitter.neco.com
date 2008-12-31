class TwitterUser < ActiveRecord::Base
  has_many :tweets, :order => 'tweets.tweeted_at desc'
end
