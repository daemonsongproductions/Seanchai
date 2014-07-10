require "test_helper"

class UsersControllerTest < MiniTest::Unit::TestCase

  def test_sanity
    skip("leaving this as an example of unit test syntax in minitest")
  end

end

describe "UsersController" do

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