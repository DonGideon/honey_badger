class TwitterController < ApplicationController
	require 'rest_client'
	before_filter :user_redirect?, only: [:tomato_search]
	before_filter :user_ajax?, only: [:search_tweets, :history]

	def tomato_search
	end

	def history
		render :json => @user.searches.inject([]){|arr, search| h = {}; h[:created_at] = search.created_at; h[:tweets] = search.tweets.first(10); arr << h; arr}
	end

	def search_tweets
		key = URI::encode('utixerhF1EVbxPhkp37Umlew7')
    secret = URI::encode('6VdsCafZffZJcfBeCRvCGMIWxRWyMmgqeYofgoIVGtfYK260FP')
    encoded = Base64.strict_encode64("#{key}:#{secret}")

    res = RestClient::Resource.new "https://api.twitter.com/oauth2/token/"
    response = ''

    options = {}
    options['Authorization'] = "Basic #{encoded}"
    options['Content-Type'] = 'application/x-www-form-urlencoded;charset=UTF-8'

    a = res.post('grant_type=client_credentials', options)

    token = JSON.parse(a)["access_token"]

    res = RestClient::Resource.new URI.escape("https://api.twitter.com/1.1/search/tweets.json?q=tomato&lang=en")
    response = ''

    options = {}
    options['Authorization'] = "Bearer #{token}"

    a = res.get(options)

    keys = %w{created_at text}
    user_keys = %w{profile_image_url_https name screen_name}
    tweets_arr = JSON.parse(a)["statuses"].inject([]){|arr, h| arr << (h.select{|k,v| keys.include? k}).merge(h["user"].select{|kk,vv| user_keys.include? kk}); arr}
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
			unless user_cookie?
				redirect_to users_sign_in_path
			end
		end

		def user_ajax?
			unless user_cookie?
				render :json => {error: "not sign in", url: users_sign_in_url}
			end
		end

		def user_cookie?
			@user = cookies[:twitter_user_id] && User.find_by(id: cookies[:twitter_user_id])
		end
end
