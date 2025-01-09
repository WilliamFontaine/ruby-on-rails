require "test_helper"

class SavsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get savs_index_url
    assert_response :success
  end

  test "should get show" do
    get savs_show_url
    assert_response :success
  end

  test "should get new" do
    get savs_new_url
    assert_response :success
  end

  test "should get edit" do
    get savs_edit_url
    assert_response :success
  end

  test "should get create" do
    get savs_create_url
    assert_response :success
  end

  test "should get update" do
    get savs_update_url
    assert_response :success
  end

  test "should get destroy" do
    get savs_destroy_url
    assert_response :success
  end

  test "should get update_returned_today" do
    get savs_update_returned_today_url
    assert_response :success
  end
end
