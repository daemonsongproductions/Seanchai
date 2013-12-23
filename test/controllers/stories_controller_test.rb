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
      get :index, format: 'json'
      assert_response :success
    end
  end

  describe "index" do

    describe "authorization" do

      it "should return successfully for guest" do
        set_guest_user
        get :index
        assert_response :success
      end

      it "should return successfully for member" do
        set_member_user
        get :index
        assert_response :success
      end

      it "should return successfully for admin" do
        set_admin_user
        get :index
        assert_response :success
      end
    end

    it "should return a list of all stories" do
      set_guest_user
      FactoryGirl.create(:story, title: "This is a thing I'm doing")
      FactoryGirl.create(:story, title: "I will read this story")

      get :index, format: 'json'
      assert_equal 2, ActiveSupport::JSON.decode(response.body)["stories"].count
      assert_equal 'this-is-a-thing-im-doing', ActiveSupport::JSON.decode(response.body)["stories"][0]["id"]
    end

  end

  describe "show" do

    describe "authorization" do

      before :each do
        story = mock("story")
        story.expects(:as_json).returns({})
        Story.expects(:find).with("id").returns(story)
      end

      it "should return successfully for guest" do
        set_guest_user
        get :show, id: "id", format: 'json'
        assert_response :success
      end

      it "should return successfully for member" do
        set_member_user
        get :show, id: "id", format: 'json'
        assert_response :success
      end

      it "should return successfully for admin" do
        set_admin_user
        get :show, id: "id", format: 'json'
        assert_response :success
      end

    end

  end

  describe "create" do

    describe "authorization" do
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

    it "should return success on successful creation" do
      set_member_user
      story = FactoryGirl.create(:story, title: "This is a thing I'm doing")
      Story.expects(:new).with('title' => "This is a thing I'm doing",
                               'description' => 'description',
                               'copyright' => 'copyright',
                               'creator' => @controller.current_user).returns(story)

      post :create, format: 'json', story: {title: "This is a thing I'm doing", description: "description", copyright: "copyright"}
      assert_response :success
      puts response.body
      assert_equal "this-is-a-thing-im-doing", ActiveSupport::JSON.decode(response.body)["story"]["id"]
    end

    it "should return unprocessable entity on unsuccessful creation" do
      set_member_user
      story = mock("story")
      Story.expects(:new).returns(story)
      story.expects(:save).returns(false)
      story.expects(:errors).returns({})
      post :create, format: 'json', story: {title: "Title"}
      assert_response :unprocessable_entity
    end

  end

  describe "edit" do

    before :each do
      story = mock("story")
      story.expects(:as_json).returns({})
      Story.expects(:find).with("id").returns(story)
    end

    it "should return successfully for guest" do
      set_guest_user
      get :edit, id: "id", format: 'json'
      assert_response :success
    end

    it "should return successfully for member" do
      set_member_user
      get :edit, id: "id", format: 'json'
      assert_response :success
    end

    it "should return successfully for admin" do
      set_admin_user
      get :edit, id: "id", format: 'json'
      assert_response :success
    end

  end

  describe "destroy" do

  end

end