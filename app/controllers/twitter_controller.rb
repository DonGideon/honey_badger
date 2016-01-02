class TwitterController < ApplicationController
	include TwitterApiCalls
	before_filter :user_redirect?, only: [:tomato_search]
	before_filter :user_ajax?, only: [:search_tweets, :history]

	def tomato_search
	end

	def history
		render :json => @user.serches_history
	end

	def search_tweets
    tweets_arr = search_call("tomato")
    search = Search.create(user: @user)
    tweets_arr.each do |tweet|
    	Tweet.create(
    		search: 											search,
    		user_name: 										tweet["name"],
	      user_screen_name: 						tweet["screen_name"],
	      user_profile_image_url_https: tweet["profile_image_url_https"],
	      tweet_created_at: 						tweet["created_at"],
	      tweet_text: 									tweet["text"]
    	)
    end
    render :json => search.tweets
	end

	private
		def user_redirect?
			redirect_to users_sign_in_path unless user_cookie?
		end

		def user_ajax?
			render :json => {error: "not sign in", url: users_sign_in_url} unless user_cookie?
		end

		def user_cookie?
			@user = cookies[:twitter_user_id] && User.find_by(id: cookies[:twitter_user_id])
		end
end
