require 'test_helper'

class ChaptersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chapters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chapter" do
    assert_difference('Chapter.count') do
      post :create, :chapter => { }
    end

    assert_redirected_to chapter_path(assigns(:chapter))
  end

  test "should show chapter" do
    get :show, :id => chapters(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => chapters(:one).to_param
    assert_response :success
  end

  test "should update chapter" do
    put :update, :id => chapters(:one).to_param, :chapter => { }
    assert_redirected_to chapter_path(assigns(:chapter))
  end

  test "should destroy chapter" do
    assert_difference('Chapter.count', -1) do
      delete :destroy, :id => chapters(:one).to_param
    end

    assert_redirected_to chapters_path
  end
end
