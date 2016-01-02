module TwitterApiCalls
	require 'rest_client'

	def auth_call
		key = URI::encode(ENV["TWITTER_HONEY_BADGER_KEY"])
    secret = URI::encode(ENV["TWITTER_HONEY_BADGER_SECRET"])
    encoded = Base64.strict_encode64("#{key}:#{secret}")

    res = RestClient::Resource.new "https://api.twitter.com/oauth2/token/"

    options = {}
    options['Authorization'] = "Basic #{encoded}"
    options['Content-Type'] = 'application/x-www-form-urlencoded;charset=UTF-8'

    respond = res.post('grant_type=client_credentials', options)
    token = JSON.parse(respond)["access_token"]
	end

	def search_call(search_me)
		token = auth_call
		res = RestClient::Resource.new URI.escape("https://api.twitter.com/1.1/search/tweets.json?q=#{search_me}&lang=en")

    options = {'Authorization' => "Bearer #{token}"}

    respond = res.get(options)

    keys = %w{created_at text}
    user_keys = %w{profile_image_url_https name screen_name}
    JSON.parse(respond)["statuses"].inject([]){|arr, h| arr << (h.select{|k,v| keys.include? k}).merge(h["user"].select{|kk,vv| user_keys.include? kk}); arr}
	end

end