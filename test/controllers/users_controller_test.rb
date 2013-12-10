require "test_helper"

class UsersControllerTest < MiniTest::Unit::TestCase
  include Mongoid::Matchers

  def test_sanity
    skip("leaving this as an example of unit test syntax in minitest")
  end

end

describe "UsersController" do

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "show" do
    it "should return successfully" do

        get :index
        assert_response :success
    end
  end

end