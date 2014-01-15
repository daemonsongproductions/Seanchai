require "test_helper"
describe "StatusesController" do

  describe "index" do

    it "should return successfully for guest" do
      set_guest_user
      get :index, format: 'json'
      assert_response :success
      assert_equal true, ActiveSupport::JSON.decode(response.body)["statuses"].any? {|section| section["name"] == "Published"}
    end

    it "should return successfully for member" do
      set_member_user
      get :index, format: 'json'
      assert_response :success
      assert_equal true, ActiveSupport::JSON.decode(response.body)["statuses"].any? {|section| section["name"] == "Published"}
    end

    it "should return successfully for admin" do
      set_admin_user
      get :index, format: 'json'
      assert_response :success
      assert_equal true, ActiveSupport::JSON.decode(response.body)["statuses"].any? {|section| section["name"] == "Published"}
    end
  end


end