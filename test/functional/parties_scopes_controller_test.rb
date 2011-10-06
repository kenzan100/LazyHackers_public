require 'test_helper'

class PartiesScopesControllerTest < ActionController::TestCase
  setup do
    @parties_scope = parties_scopes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parties_scopes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parties_scope" do
    assert_difference('PartiesScope.count') do
      post :create, :parties_scope => @parties_scope.attributes
    end

    assert_redirected_to parties_scope_path(assigns(:parties_scope))
  end

  test "should show parties_scope" do
    get :show, :id => @parties_scope.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @parties_scope.to_param
    assert_response :success
  end

  test "should update parties_scope" do
    put :update, :id => @parties_scope.to_param, :parties_scope => @parties_scope.attributes
    assert_redirected_to parties_scope_path(assigns(:parties_scope))
  end

  test "should destroy parties_scope" do
    assert_difference('PartiesScope.count', -1) do
      delete :destroy, :id => @parties_scope.to_param
    end

    assert_redirected_to parties_scopes_path
  end
end
