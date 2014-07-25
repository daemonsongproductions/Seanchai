require "test_helper"

class UsersControllerTest < MiniTest::Test

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

  describe "create" do

    it "should return unprocessable if all fields are not present" do
      skip
      set_guest_user
      role = Creator.new
      Creator.expects(:new).returns(role)
      user = FactoryGirl.create(:user, email: "email@email.com", username: "user", role: role)
      User.expects(:new).with('username' => "user",
                               'email' => 'email@email.com',
                               'password' => 'password',
                               'password_confirmation' => 'password', 'role' => role).returns(user)
      post :create, format: 'json', user: {username: "user",
                                           email: "email@email.com"}
      assert_response :unprocessable_entity
    end

    it "should return successfully if a user chooses to be a reader"
    it "should return successfully if a user chooses to be a creator"

  end

end