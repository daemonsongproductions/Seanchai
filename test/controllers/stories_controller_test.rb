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
      story = mock("story")
      Story.expects(:new).with('title' => "Title",
                               'description' => 'description',
                               'copyright' => 'copyright',
                               'creator' => @controller.current_user).returns(story)
      story.expects(:save).returns(true)
      story.expects(:as_json).returns({})
      post :create, format: 'json', story: {title: "Title", description: "description", copyright: "copyright"}
      assert_response :success
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

end