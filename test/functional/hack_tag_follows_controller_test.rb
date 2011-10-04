require 'test_helper'

class HackTagFollowsControllerTest < ActionController::TestCase
  setup do
    @hack_tag_follow = hack_tag_follows(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hack_tag_follows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hack_tag_follow" do
    assert_difference('HackTagFollow.count') do
      post :create, :hack_tag_follow => @hack_tag_follow.attributes
    end

    assert_redirected_to hack_tag_follow_path(assigns(:hack_tag_follow))
  end

  test "should show hack_tag_follow" do
    get :show, :id => @hack_tag_follow.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @hack_tag_follow.to_param
    assert_response :success
  end

  test "should update hack_tag_follow" do
    put :update, :id => @hack_tag_follow.to_param, :hack_tag_follow => @hack_tag_follow.attributes
    assert_redirected_to hack_tag_follow_path(assigns(:hack_tag_follow))
  end

  test "should destroy hack_tag_follow" do
    assert_difference('HackTagFollow.count', -1) do
      delete :destroy, :id => @hack_tag_follow.to_param
    end

    assert_redirected_to hack_tag_follows_path
  end
end
