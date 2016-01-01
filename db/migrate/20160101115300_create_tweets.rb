class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :user_name
      t.string :user_screen_name
      t.string :user_profile_image_url_https
      t.string :tweet_created_at
      t.string :tweet_text
      t.belongs_to :search, index: true

      t.timestamps null: false
    end
  end
end
