class SideBarController < ApplicationController
  def index
  end

  def test_json()
  	render "side_bar_json.json", layout: false
  end
end
