require 'test_helper'

class TwitterControllerTest < ActionController::TestCase

	# tomato_search
	# history
	# search_tweets

  test "should return error when user not sign_in get_search_tweets" do
    get :search_tweets
    return_json = JSON.parse(response.body)
    assert_equal "not sign in", return_json["error"]
    assert_equal users_sign_in_url, return_json["url"]
  end

  test "should return error when user not sign_in get_history" do
    get :history
    return_json = JSON.parse(response.body)
    assert_equal "not sign in", return_json["error"]
    assert_equal users_sign_in_url, return_json["url"]
  end

  test "should redirect to users_sign_in_path when user not sign_in get_tomato_search" do
    get :tomato_search
    assert_redirected_to users_sign_in_path
  end

  test "should redirect to users_sign_in_path when manipulate cookie get_tomato_search" do
  	user = users(:user_one)
  	cookies[:twitter_user_id] = user.id+1
    get :tomato_search
    assert_redirected_to users_sign_in_path
  end
 
  test "should tomato_search get_tomato_search" do
  	user = users(:user_one)
  	cookies[:twitter_user_id] = user.id
    get :tomato_search
    assert_response :success
    assert_template :tomato_search
  end

  test "should return json with user history get_history" do
  	user = users(:user_two)
  	cookies[:twitter_user_id] = user.id
  	search = searches(:search_two)
    get :history
    return_json = JSON.parse(response.body)
    assert_equal search.created_at, return_json[0]["created_at"]
    assert_equal search.id, return_json[0]["tweets"][0]["search_id"]
  end

end
