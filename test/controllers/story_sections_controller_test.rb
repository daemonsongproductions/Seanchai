describe "StorySectionsController" do

  describe "index" do

    before :each do
      @story = FactoryGirl.create(:story, title: "Story 1")
      @story.story_sections.create(title: "Chapter 1")
      @story.story_sections.create(title: "Chapter 2")
      @story.story_sections.create(title: "Chapter 3")
    end


    it "should return successfully for guest" do
      set_guest_user
      get :index, format: 'json', story_id: 'story-1'
      assert_response :success
      assert_equal true, ActiveSupport::JSON.decode(response.body)["story_sections"].any? {|section| section["id"] == "chapter-1"}
    end

    it "should return successfully for member" do
      set_member_user
      get :index, format: 'json', story_id: 'story-1'
      assert_response :success
      assert_equal true, ActiveSupport::JSON.decode(response.body)["story_sections"].any? {|section| section["id"] == "chapter-1"}
    end

    it "should return successfully for admin" do
      set_admin_user
      get :index, format: 'json', story_id: 'story-1'
      assert_response :success
      assert_equal true, ActiveSupport::JSON.decode(response.body)["story_sections"].any? {|section| section["id"] == "chapter-1"}
    end

    it "should return not found for invalid story ids" do
      set_guest_user
      get :index, format: 'json', story_id: 'story-2'
      assert_response :not_found
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
      user = FactoryGirl.create(:user, email: "member@email.com", username: "member")
      set_current_user(user)
      FactoryGirl.create(:story, title: "This is a thing I'm doing", creator: user, status: Status.published)

      post :create, {format: 'json',
                     story_section: {title: "Chapter 1", story_id: 'this-is-a-thing-im-doing',}}
      assert_response :success
      assert_equal "chapter-1", ActiveSupport::JSON.decode(response.body)["story_section"]["id"]
    end

    it "should return unprocessable entity on unsuccessful creation" do
      user = FactoryGirl.create(:user, email: "member@email.com", username: "member")
      set_current_user(user)
      FactoryGirl.create(:story, title: "This", creator: user, status: Status.published)
      post :create, { format: 'json', story_section: {story_id: "this"}}
      assert_response :unprocessable_entity
    end

    it "should return unauthorized if the story doesn't exist" do
      user = FactoryGirl.create(:user, email: "member@email.com", username: "member")
      set_current_user(user)
      FactoryGirl.create(:story, title: "This Sucks", creator: user)
      post :create, {format: 'json', story_section: {story_id: "this"}}
      assert_response :unauthorized
    end

  end

end