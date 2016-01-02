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

    a = res.post('grant_type=client_credentials', options)

    @token = JSON.parse(a)["access_token"]
	end

	def search_call(search_me)
		auth_call unless @token
		res = RestClient::Resource.new URI.escape("https://api.twitter.com/1.1/search/tweets.json?q=#{search_me}&lang=en")

    options = {}
    options['Authorization'] = "Bearer #{@token}"

    a = res.get(options)

    keys = %w{created_at text}
    user_keys = %w{profile_image_url_https name screen_name}
    JSON.parse(a)["statuses"].inject([]){|arr, h| arr << (h.select{|k,v| keys.include? k}).merge(h["user"].select{|kk,vv| user_keys.include? kk}); arr}
	end

end