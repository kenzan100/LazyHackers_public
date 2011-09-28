require 'test_helper'

class UsersScopesControllerTest < ActionController::TestCase
  setup do
    @users_scope = users_scopes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users_scopes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create users_scope" do
    assert_difference('UsersScope.count') do
      post :create, :users_scope => @users_scope.attributes
    end

    assert_redirected_to users_scope_path(assigns(:users_scope))
  end

  test "should show users_scope" do
    get :show, :id => @users_scope.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @users_scope.to_param
    assert_response :success
  end

  test "should update users_scope" do
    put :update, :id => @users_scope.to_param, :users_scope => @users_scope.attributes
    assert_redirected_to users_scope_path(assigns(:users_scope))
  end

  test "should destroy users_scope" do
    assert_difference('UsersScope.count', -1) do
      delete :destroy, :id => @users_scope.to_param
    end

    assert_redirected_to users_scopes_path
  end
end
