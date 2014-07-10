require "test_helper"
describe "StorySectionsController" do

  describe "index" do

    before :each do
      @story = FactoryGirl.create(:story, title: "Story 1", status: Status.published)
      @section_1 = @story.story_sections.create(title: "Chapter 1", status: Status.published)
      @section_2 = @story.story_sections.create(title: "Chapter 2", status: Status.published)
      @section_3 = @story.story_sections.create(title: "Chapter 3", status: Status.published)
    end

    it "should return successfully for guest" do
      set_guest_user
      get :index, format: 'json', story_id: 'story-1'
      assert_response :success
      assert_equal true, ActiveSupport::JSON.decode(response.body)["story_sections"].any? {|section| section["slug"] == "chapter-1"}
    end

    it "should return successfully for member" do
      set_member_user
      get :index, format: 'json', story_id: 'story-1'
      assert_response :success
      assert_equal 'chapter-1', ActiveSupport::JSON.decode(response.body)["story_sections"][0]["slug"]
      assert_equal true, ActiveSupport::JSON.decode(response.body)["story_sections"].any? {|section| section["slug"] == "chapter-1"}
    end

    it "should return successfully for admin" do
      set_admin_user
      get :index, format: 'json', story_id: 'story-1'
      assert_response :success
      assert_equal true, ActiveSupport::JSON.decode(response.body)["story_sections"].any? {|section| section["slug"] == "chapter-1"}
    end

    it "should return not found for invalid story ids" do
      set_guest_user
      get :index, format: 'json', story_id: 'story-2'
      assert_response :not_found
    end

    it "should return the correct section by story and order" do
      set_guest_user
      get :index, format: 'json', story_id: 'story-1', order: 2
      assert_equal true, ActiveSupport::JSON.decode(response.body)["story_sections"].any? {|section| section["slug"] == "chapter-2"}
    end

    it "should returns a list of sections for the supplied ids" do
      set_guest_user
      get :index, format: 'json', ids: [@story.story_sections[1].id]
      assert_equal true, ActiveSupport::JSON.decode(response.body)["story_sections"].any? {|section| section["slug"] == "chapter-2"}
    end

    describe "next/previous section" do
      it "should display the id of the Previous Item" do
        set_guest_user
        get :index, format: 'json', story_id: 'story-1'
        assert_equal @section_1.order, ActiveSupport::JSON.decode(response.body)["story_sections"][1]["previous_section"]
      end
      it "should have nil as Previous Item if item is first" do
        set_guest_user
        get :index, format: 'json', story_id: 'story-1'
        assert_equal nil, ActiveSupport::JSON.decode(response.body)["story_sections"][0]["previous_section"]
      end

      it "should display the id of the Next Item" do
        set_guest_user
        get :index, format: 'json', story_id: 'story-1'
        assert_equal @section_2.order, ActiveSupport::JSON.decode(response.body)["story_sections"][0]["next_section"]
      end

      it "should have nil as Next Item if the item is last" do
        set_guest_user
        get :index, format: 'json', story_id: 'story-1'
        assert_equal nil, ActiveSupport::JSON.decode(response.body)["story_sections"][2]["next_section"]
      end

    end


  end

  describe "show" do

    before :each do
      @story = FactoryGirl.create(:story, title: "Story 1", status: Status.published)
      @section_1 = @story.story_sections.create(title: "Chapter 1", status: Status.published)
      @story.story_sections.create(title: "Chapter 2")
      @story.story_sections.create(title: "Chapter 3")
    end

    it "should return successfully for guest" do
      set_guest_user
      get :show, id: @section_1.id, format: 'json'
      assert_response :success
    end

    it "should return successfully for member" do
      set_member_user
      get :show, id: @section_1.id, format: 'json'
      assert_response :success
    end

    it "should return successfully for admin" do
      set_admin_user
      get :show, id: @section_1.id, format: 'json'
      assert_response :success
    end

  end

  describe "create" do

    describe "authorization" do
      it "should return unauthorized for guest" do
        set_guest_user
        FactoryGirl.create(:story, title: "This", status: Status.published)
        post :create, {story_section: {title: "This", story_id: 'this'}, format: 'json'}
        assert_response :unauthorized
      end
    end

    it "should return success on successful creation" do
      user = FactoryGirl.create(:user, email: "member@email.com", username: "member", role: Creator.new)
      set_current_user(user)
      FactoryGirl.create(:story, title: "This is a thing I'm doing", creator: user, status: Status.published)

      post :create, {format: 'json',
                     story_section: {title: "Chapter 1", story_id: 'this-is-a-thing-im-doing',}}
      assert_response :success
      assert_equal "chapter-1", ActiveSupport::JSON.decode(response.body)["story_section"]["slug"]
    end

    it "should return unprocessable entity on unsuccessful creation" do
      user = FactoryGirl.create(:user, email: "member@email.com", username: "member", role: Creator.new)
      set_current_user(user)
      FactoryGirl.create(:story, title: "This", creator: user, status: Status.published)
      post :create, { format: 'json', story_section: {story_id: "this"}}
      assert_response :unprocessable_entity
    end

    it "should return unauthorized if the story doesn't exist" do
      user = FactoryGirl.create(:user, email: "member@email.com", username: "member", role: Creator.new)
      set_current_user(user)
      FactoryGirl.create(:story, title: "This Sucks", creator: user)
      post :create, {format: 'json', story_section: {story_id: "this"}}
      assert_response :unauthorized
    end

  end

  describe "update" do

    before :each do
      @creator = FactoryGirl.create(:user, email: "creator@creator.com", username: "creatrix", role: Creator.new)
      @story = FactoryGirl.create(:story, title: "Story 1", creator: @creator, status: Status.published)
      @story_section = @story.story_sections.create(title: "Chapter 1")
    end

    it "should return unauthorized for guest" do
      set_guest_user
      put :update, {format: 'json', id: @story_section.id,
                    story_section: {title: "Chapter 1 is death", story_id: @story.id}}
      assert_response :unauthorized
    end

    it "should return successfully for the creator" do
      set_current_user(@creator)
      put :update, {format: 'json', id: @story_section.id,
                    story_section: {title: "Chapter 1 is death", story_id: @story.id}}
      assert_response :success
    end

    it "should return unauthorized for any user but the creator" do
      set_member_user
      put :update, {format: 'json', id: @story_section.id,
                    story_section: {title: "Chapter 1 is death", story_id: @story.id}}
      assert_response :unauthorized
    end

  end

end