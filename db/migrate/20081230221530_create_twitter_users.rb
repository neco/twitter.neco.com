class CreateTwitterUsers < ActiveRecord::Migration
  def self.up
    create_table :twitter_users do |t|
      t.string :name
      t.string :location
      t.string :profile_image_url
      t.string :url
      t.integer :twitter_id
      t.integer :followers_count
      t.string :description
      t.string :screen_name

      t.timestamps
    end
    add_index :twitter_users, [:screen_name, :twitter_id]
  end

  def self.down
    drop_table :twitter_users
  end
end
