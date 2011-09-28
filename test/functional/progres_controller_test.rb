require 'test_helper'

class ProgresControllerTest < ActionController::TestCase
  setup do
    @progre = progres(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:progres)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create progre" do
    assert_difference('Progre.count') do
      post :create, :progre => @progre.attributes
    end

    assert_redirected_to progre_path(assigns(:progre))
  end

  test "should show progre" do
    get :show, :id => @progre.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @progre.to_param
    assert_response :success
  end

  test "should update progre" do
    put :update, :id => @progre.to_param, :progre => @progre.attributes
    assert_redirected_to progre_path(assigns(:progre))
  end

  test "should destroy progre" do
    assert_difference('Progre.count', -1) do
      delete :destroy, :id => @progre.to_param
    end

    assert_redirected_to progres_path
  end
end
