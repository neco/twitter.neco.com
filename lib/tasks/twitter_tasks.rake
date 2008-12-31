namespace :twitter do
  desc 'Fetch updates for all our twitter users'
  task :update => :environment do
    TwitterUser.all.each do |user|
      twitter = Twitter.new
      
      query = {:id => user.screen_name}
      query[:count] = 200 # this is the maximum allowed
      query[:since_id] = user.tweets.first.tweet_id unless user.tweets.empty?
      
      new_tweets = twitter.timeline(:user, :query => query)
      
      # update user information
      if new_tweets.size > 0
        user_info = new_tweets.first['user']
        %w[name location profile_image_url url followers_count description screen_name].each do |field|
          user.send("#{field}=", user_info[field])
        end
        
        user.twitter_id = user_info['id'] 
        user.save
      end
      
      new_tweets.each do |tweet|
        user.tweets.create({
          :tweeted_at => tweet['created_at'],
          :tweet_text => tweet['text'],
          :tweet_id => tweet['id'],
          :in_reply_to_screen_name => tweet['in_reply_to_screen_name']
        })
      end
      
      puts "Created #{new_tweets.size} tweets for #{user.screen_name}"
    end
  end
end