require "test_helper"

class HousingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get housings_index_url
    assert_response :success
  end

  test "should get show" do
    get housings_show_url
    assert_response :success
  end

  test "should get new" do
    get housings_new_url
    assert_response :success
  end

  test "should get create" do
    get housings_create_url
    assert_response :success
  end
end
