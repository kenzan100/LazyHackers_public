require 'test_helper'

class ScopesControllerTest < ActionController::TestCase
  setup do
    @scope = scopes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scopes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scope" do
    assert_difference('Scope.count') do
      post :create, :scope => @scope.attributes
    end

    assert_redirected_to scope_path(assigns(:scope))
  end

  test "should show scope" do
    get :show, :id => @scope.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @scope.to_param
    assert_response :success
  end

  test "should update scope" do
    put :update, :id => @scope.to_param, :scope => @scope.attributes
    assert_redirected_to scope_path(assigns(:scope))
  end

  test "should destroy scope" do
    assert_difference('Scope.count', -1) do
      delete :destroy, :id => @scope.to_param
    end

    assert_redirected_to scopes_path
  end
end
