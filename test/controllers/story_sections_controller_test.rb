describe "StorySectionsController" do

  describe "create" do

    describe "authorization" do
      it "should return unauthorized for guest" do
        set_guest_user
        FactoryGirl.create(:story, title: "This", status: Status.published)
        post :create, {story_id: "this", story_section: {title: "This"}, format: 'json'}
        assert_response :unauthorized
      end
    end

    it "should return success on successful creation" do
      user = FactoryGirl.create(:user, email: "member@email.com", username: "member")
      set_current_user(user)
      FactoryGirl.create(:story, title: "This is a thing I'm doing", creator: user, status: Status.published)

      post :create, {story_id: 'this-is-a-thing-im-doing',
                     format: 'json',
                     story_section: {title: "Chapter 1"}}
      assert_response :success
      assert_equal "chapter-1", ActiveSupport::JSON.decode(response.body)["story_section"]["id"]
    end

    it "should return unprocessable entity on unsuccessful creation" do
      user = FactoryGirl.create(:user, email: "member@email.com", username: "member")
      set_current_user(user)
      FactoryGirl.create(:story, title: "This", creator: user, status: Status.published)
      post :create, {story_id: "this", format: 'json', story_section: {}}
      assert_response :unprocessable_entity
    end

    it "should return unauthorized if the story doesn't exist" do
      user = FactoryGirl.create(:user, email: "member@email.com", username: "member")
      set_current_user(user)
      FactoryGirl.create(:story, title: "This Sucks", creator: user)
      post :create, {story_id: "this", format: 'json', story_section: {}}
      assert_response :unauthorized
    end

  end

end