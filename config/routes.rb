Rails.application.routes.draw do

  root 'twitter#tomato_search'

  get 'side_bar' => 'side_bar#index'
  get 'side_bar/test_json' => 'side_bar#test_json'

  get 'twitter/tomato' => 'twitter#tomato_search'
  get 'twitter/search_tweets' => 'twitter#search_tweets'
  get 'twitter/history' => 'twitter#history'

  get 'users/sign_in' => 'users#sign_in'
  post 'users/can_create' => 'users#can_create'
  get 'users/log_out' => 'users#log_out'

end
