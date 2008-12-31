class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.integer :twitter_user_id
      t.datetime :tweeted_at
      t.string :tweet_text
      t.integer :tweet_id
      t.string :in_reply_to_screen_name

      t.timestamps
    end
    add_index :tweets, [:twitter_user_id, :tweeted_at]
  end

  def self.down
    drop_table :tweets
  end
end
