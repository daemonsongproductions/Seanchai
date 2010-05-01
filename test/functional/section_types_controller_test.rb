require 'test_helper'

class SectionTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:section_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create section_type" do
    assert_difference('SectionType.count') do
      post :create, :section_type => { }
    end

    assert_redirected_to section_type_path(assigns(:section_type))
  end

  test "should show section_type" do
    get :show, :id => section_types(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => section_types(:one).to_param
    assert_response :success
  end

  test "should update section_type" do
    put :update, :id => section_types(:one).to_param, :section_type => { }
    assert_redirected_to section_type_path(assigns(:section_type))
  end

  test "should destroy section_type" do
    assert_difference('SectionType.count', -1) do
      delete :destroy, :id => section_types(:one).to_param
    end

    assert_redirected_to section_types_path
  end
end
