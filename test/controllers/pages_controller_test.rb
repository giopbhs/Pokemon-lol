require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get credits" do
    get :credits
    assert_response :success
  end

  test "should get resources" do
    get :resources
    assert_response :success
  end

end
