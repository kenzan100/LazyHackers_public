require 'test_helper'

class UsersHacktagsControllerTest < ActionController::TestCase
  setup do
    @users_hacktag = users_hacktags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users_hacktags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create users_hacktag" do
    assert_difference('UsersHacktag.count') do
      post :create, :users_hacktag => @users_hacktag.attributes
    end

    assert_redirected_to users_hacktag_path(assigns(:users_hacktag))
  end

  test "should show users_hacktag" do
    get :show, :id => @users_hacktag.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @users_hacktag.to_param
    assert_response :success
  end

  test "should update users_hacktag" do
    put :update, :id => @users_hacktag.to_param, :users_hacktag => @users_hacktag.attributes
    assert_redirected_to users_hacktag_path(assigns(:users_hacktag))
  end

  test "should destroy users_hacktag" do
    assert_difference('UsersHacktag.count', -1) do
      delete :destroy, :id => @users_hacktag.to_param
    end

    assert_redirected_to users_hacktags_path
  end
end
