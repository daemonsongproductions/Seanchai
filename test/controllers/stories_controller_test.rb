require "test_helper"

class StoriesControllerTest < MiniTest::Unit::TestCase
  include Mongoid::Matchers

  def test_sanity
    skip("leaving this as an example of unit test syntax in minitest")
  end

end

describe "StoriesController" do

  describe "index" do
    it "should return successfully" do
      get :index
      assert_response :success
    end
  end

  describe "create" do
    it "should return unauthorized for guest" do
      set_guest_user
      post :create, format: 'json'
      assert_response :unauthorized

    end

    it "should return Bad Request for a member's empty post" do
      set_member_user
      post :create, format: 'json'
      assert_response :bad_request
    end

    it "should return Bad Request for an admin's empty post" do
      set_admin_user
      post :create, format: 'json'
      assert_response :bad_request

    end
  end

end