require 'test_helper'

class HacksScopesControllerTest < ActionController::TestCase
  setup do
    @hacks_scope = hacks_scopes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hacks_scopes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hacks_scope" do
    assert_difference('HacksScope.count') do
      post :create, :hacks_scope => @hacks_scope.attributes
    end

    assert_redirected_to hacks_scope_path(assigns(:hacks_scope))
  end

  test "should show hacks_scope" do
    get :show, :id => @hacks_scope.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @hacks_scope.to_param
    assert_response :success
  end

  test "should update hacks_scope" do
    put :update, :id => @hacks_scope.to_param, :hacks_scope => @hacks_scope.attributes
    assert_redirected_to hacks_scope_path(assigns(:hacks_scope))
  end

  test "should destroy hacks_scope" do
    assert_difference('HacksScope.count', -1) do
      delete :destroy, :id => @hacks_scope.to_param
    end

    assert_redirected_to hacks_scopes_path
  end
end
