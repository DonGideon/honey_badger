require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # sign_in
  # can_create
  # log_out

  test "should sign_in get_sign_in" do
  	user = users(:user_one)
    get :sign_in
    assert_response :success
    assert_template :sign_in
  end

  test "should not create user when call can_create when no name post_history" do
    post :can_create, {name: nil}
    return_json = JSON.parse(response.body)
    assert_equal false, return_json["success"]
  end

  test "should create user when call can_create post_history" do
    post :can_create, {name: "user name"}
    return_json = JSON.parse(response.body)
    assert_equal true, return_json["success"]
    assert_equal twitter_tomato_url, return_json["url"]
  end

  test "should find user when call can_create with exist user name post_history" do
    user = users(:user_one)
    post :can_create, {name: "user_one"}
    return_json = JSON.parse(response.body)
    assert_equal true, return_json["success"]
    assert_equal twitter_tomato_url, return_json["url"]
    assert_equal user.id, cookies[:twitter_user_id]
  end

  test "should redirect to users_sign_in_path get_log_out" do
    get :log_out
    assert_redirected_to users_sign_in_path
  end

  test "should delete cookies[:twitter_user_id] get_log_out" do
  	cookies[:twitter_user_id] = 1
    get :log_out
    assert_equal nil, cookies[:twitter_user_id]
  end
end
