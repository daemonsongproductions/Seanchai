require "test_helper"

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

    it "should returns all stories from a specific user" do
      set_guest_user
      FactoryGirl.create(:story, title: "This is a thing I'm doing")
      FactoryGirl.create(:story, title: "I will read this story", creator:
          FactoryGirl.create(:user, username: "user2", email: "user2@user.com")
      )

      get :index, {username: "saalon", format: 'json'}
      assert_equal 1, ActiveSupport::JSON.decode(response.body)["stories"].count
      assert_equal "This is a thing I'm doing", ActiveSupport::JSON.decode(response.body)["stories"][0]["title"]

    end

  end

  describe "show" do

    describe "authorization" do

      before :each do
        FactoryGirl.create(:story, title: "id")
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
        post :create, {story: {title: "This"}, format: 'json'}
        assert_response :unauthorized
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
      @story = FactoryGirl.create(:story, title: "This is a thing I'm doing")
      @story.save
    end

    it "should return unauthorized for guest" do
      set_guest_user
      get :edit, id: "this-is-a-thing-im-doing", format: 'json'
      assert_response :unauthorized
    end

    it "should return successfully for the creator" do
      set_member_user
      @controller.expects(:current_resource).returns(@story)
      @story.creator.expects(:id).returns("id")
      get :edit, id: "this-is-a-thing-im-doing", format: 'json'
      assert_response :success
    end

    it "should return unauthorized for any user but the creator" do
      user = mock_user_with_role(Member, "other_id")
      set_current_user(user)
      get :edit, id: "this-is-a-thing-im-doing", format: 'json'
      assert_response :unauthorized
    end

    it "should return successfully for admin" do
      set_admin_user
      get :edit, id: "this-is-a-thing-im-doing", format: 'json'
      assert_response :success
    end

  end

  describe "update" do

    describe "authorization" do

      before :each do
        @story = FactoryGirl.create(:story, title: "This is a thing I'm doing")
        @story.save
      end

      it "should return unauthorized for guest" do
        set_guest_user
        put :update, {id: "this-is-a-thing-im-doing", story: { title: 'the poop'}, format: 'json'}
        assert_response :unauthorized
      end

      it "should return successfully for the creator" do
        set_member_user
        @controller.expects(:current_resource).returns(@story)
        @story.creator.expects(:id).returns("id")
        put :update, {id: "this-is-a-thing-im-doing", story: { title: 'the poop'}, format: 'json'}
        assert_response :success
      end

      it "should return unauthorized for any user but the creator" do
        set_member_user
        put :update, {id: "this-is-a-thing-im-doing", story: { title: 'the poop'}, format: 'json'}
        #get :edit, id: "this-is-a-thing-im-doing", format: 'json'
        assert_response :unauthorized
      end

    end

  end

  describe "destroy" do

  end

end