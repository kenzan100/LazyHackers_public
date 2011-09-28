require 'test_helper'

class HackTagsControllerTest < ActionController::TestCase
  setup do
    @hack_tag = hack_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hack_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hack_tag" do
    assert_difference('HackTag.count') do
      post :create, :hack_tag => @hack_tag.attributes
    end

    assert_redirected_to hack_tag_path(assigns(:hack_tag))
  end

  test "should show hack_tag" do
    get :show, :id => @hack_tag.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @hack_tag.to_param
    assert_response :success
  end

  test "should update hack_tag" do
    put :update, :id => @hack_tag.to_param, :hack_tag => @hack_tag.attributes
    assert_redirected_to hack_tag_path(assigns(:hack_tag))
  end

  test "should destroy hack_tag" do
    assert_difference('HackTag.count', -1) do
      delete :destroy, :id => @hack_tag.to_param
    end

    assert_redirected_to hack_tags_path
  end
end
