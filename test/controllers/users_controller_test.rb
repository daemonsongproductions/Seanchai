require "test_helper"

class UsersControllerTest < MiniTest::Unit::TestCase
  include Mongoid::Matchers

  def test_sanity
    skip("leaving this as an example of unit test syntax in minitest")
  end

end

describe "UsersController" do

  def mock_user_with_permit(permit_class)
    user = mock("user")
    user.stubs(:id).returns("id")
    user.stubs(:permissions).returns(permit_class.new(user))
    user
  end

  def set_current_user(user)
    @controller.stubs(:current_user).returns(user)
  end

  def set_admin_user
    set_current_user(mock_user_with_permit(Permits::AdminPermit))
  end

  def set_member_user
    set_current_user(mock_user_with_permit(Permits::MemberPermit))
  end

  def set_guest_user
    set_current_user(mock_user_with_permit(Permits::GuestPermit))
  end

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "show" do

    it "should return unauthorized for members" do
      set_member_user
      get :index, format: 'json'
      assert_response :unauthorized
    end

    it "should return unauthorized for guests" do
      set_guest_user
      get :index, format: 'json'
      assert_response :unauthorized
    end

    it "should return success for admins" do
      set_admin_user
      get :index, format: 'json'
      assert_response :success
    end
  end

end