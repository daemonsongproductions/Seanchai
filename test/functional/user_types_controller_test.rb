require 'test_helper'

class UserTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_type" do
    assert_difference('UserType.count') do
      post :create, :user_type => { }
    end

    assert_redirected_to user_type_path(assigns(:user_type))
  end

  test "should show user_type" do
    get :show, :id => user_types(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => user_types(:one).to_param
    assert_response :success
  end

  test "should update user_type" do
    put :update, :id => user_types(:one).to_param, :user_type => { }
    assert_redirected_to user_type_path(assigns(:user_type))
  end

  test "should destroy user_type" do
    assert_difference('UserType.count', -1) do
      delete :destroy, :id => user_types(:one).to_param
    end

    assert_redirected_to user_types_path
  end
end
