class TwitterController < ApplicationController
	require 'rest_client'
	before_filter :authenticate_user!, except: [:sign_in]
	def auth

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

    res = RestClient::Resource.new URI.escape("https://api.twitter.com/1.1/search/tweets.json?q=@potato OR #potato OR potato")
    response = ''

    options = {}
    options['Authorization'] = "Bearer #{token}"

    a = res.get(options)

    render :json => (a)
	end

	def sign_in
	end

	def tomato_search
	end

	def history
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

    res = RestClient::Resource.new URI.escape("https://api.twitter.com/1.1/search/tweets.json?q=tomato")
    response = ''

    options = {}
    options['Authorization'] = "Bearer #{token}"

    a = res.get(options)

    render :json => JSON.parse(a)["statuses"]
	end
end
