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

end