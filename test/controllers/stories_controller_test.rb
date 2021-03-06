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
        get :index, format: :json
        assert_response :success
      end

      it "should return successfully for member" do
        set_member_user
        get :index, format: :json
        assert_response :success
      end

      it "should return successfully for admin" do
        set_admin_user
        get :index, format: :json
        assert_response :success
      end
    end

    describe "returned stories" do

      before :each do

        # There are 4 published stories. Three by "saalon" and one by "user2"
        FactoryGirl.create(:story, title: "This is a thing I'm doing", status: Status.published)
        FactoryGirl.create(:story, title: "I will read this story", status: Status.published)
        FactoryGirl.create(:story, title: "I will read this story again", status: Status.published)
        FactoryGirl.create(:story, title: "This is a published story by another user", status: Status.published, creator:
            FactoryGirl.create(:user, username: "user2", email: "user2@user.com")
        )

        # There are 3 draft stories. Two by "saalon" and one by "user2"
        FactoryGirl.create(:story, title: "I am a draft", status: Status.draft)
        FactoryGirl.create(:story, title: "I am another draft", status: Status.draft)
        FactoryGirl.create(:story, title: "This is a draft story by another user", status: Status.draft, creator:
            FactoryGirl.create(:user, username: "user2", email: "user2@user.com")
        )
      end

      it "should return a list of all published stories" do
        set_guest_user

        get :index, format: 'json'
        assert_equal 4, ActiveSupport::JSON.decode(response.body)["stories"].count
        assert_equal true, ActiveSupport::JSON.decode(response.body)["stories"].any? {|story| story["title"] == "This is a thing I'm doing"}
      end

      it "should returns all published stories from a specific user" do
        set_guest_user
        get :index, {username: "saalon", format: 'json'}
        assert_equal 3, ActiveSupport::JSON.decode(response.body)["stories"].count
        assert_equal true, ActiveSupport::JSON.decode(response.body)["stories"].any? {|story| story["title"] == "This is a thing I'm doing"}
      end

      it "should return all stories for the current user" do
        set_current_user(FactoryGirl.create(:user, username: "user2", email: "user2@user.com"))
        get :index, {username: "user2", format: 'json'}
        assert_equal 2, ActiveSupport::JSON.decode(response.body)["stories"].count
        assert_equal true, ActiveSupport::JSON.decode(response.body)["stories"].any? {|story| story["title"] == "This is a draft story by another user"}
      end

    end
  end

  describe "show" do

    before :each do
      FactoryGirl.create(:story, title: "Story 1", status: Status.published)
      FactoryGirl.create(:story, title: "Story 2", status: Status.draft, creator:
          FactoryGirl.create(:user, username: "user2", email: "user2@user.com")
      )
    end

    describe "authorization" do

      it "should return successfully for guest" do
        set_guest_user
        get :show, id: "story-1", format: 'json'
        assert_response :success
      end

      it "should return successfully for member" do
        set_member_user
        get :show, id: "story-1", format: 'json'
        assert_response :success
      end

      it "should return successfully for admin" do
        set_admin_user
        get :show, id: "story-1", format: 'json'
        assert_response :success
      end
    end

    describe "visibility" do

      it "should return successfully for any user viewing a published story" do
        set_guest_user
        get :show, id: "story-1", format: 'json'
        assert_response :success
      end

      it "should return not found for any user but the creator viewing a draft story" do
        set_guest_user
        get :show, id: "story-2", format: 'json'
        assert_response :not_found
      end

      it "should return successfully for the current user viewing his own story, regardless of status" do
        set_current_user(FactoryGirl.create(:user, username: "user2", email: "user2@user.com"))
        get :show, id: "story-2", format: 'json'
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
      @creator = FactoryGirl.create(:user, email: "creator@creator.com", username: "creatrix", role: Creator.new)
      @story = FactoryGirl.create(:story, title: "This is a thing I'm doing", creator: @creator)
    end

    it "should return unauthorized for guest" do
      set_guest_user
      get :edit, id: "this-is-a-thing-im-doing", format: 'json'
      assert_response :unauthorized
    end

    it "should return successfully for the creator" do
      set_current_user(@creator)
      get :edit, id: "this-is-a-thing-im-doing", format: 'json'
      assert_response :success
    end

    it "should return unauthorized for any user but the creator" do
      set_member_user
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
        @creator = FactoryGirl.create(:user, email: "creator@creator.com", username: "creatrix")
        @story = FactoryGirl.create(:story, title: "This is a thing I'm doing", creator: @creator)
      end

      it "should return unauthorized for guest" do
        set_guest_user
        put :update, {id: "this-is-a-thing-im-doing", story: { title: 'the poop'}, format: 'json'}
        assert_response :unauthorized
      end

      it "should return successfully for the creator" do
        set_current_user(@creator)
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