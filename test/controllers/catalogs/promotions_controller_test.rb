require 'test_helper'

class Catalogs::PromotionsControllerTest < ActionController::TestCase
  test "should get :index" do
    get ::index
    assert_response :success
  end

end
