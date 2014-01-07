describe "StorySectionsController" do

  describe "create" do

    describe "authorization" do
      it "should return unauthorized for guest" do
        skip("Working out authorization for this")
        set_guest_user
        post :create, {story_id: "this", story_section: {title: "This"}, format: 'json'}
        assert_response :unauthorized
      end
    end

    it "should return success on successful creation" do
      skip("Working out authorization for this")
      set_member_user
      story = FactoryGirl.create(:story, title: "This is a thing I'm doing")
      Story.expects(:find).with('this-is-a-thing-im-doing').returns(story)

      post :create, {story_id: 'this-is-a-thing-im-doing',
                     format: 'json',
                     story_section: {title: "Chapter 1"}}
      assert_response :success
      assert_equal "this-is-a-thing-im-doing", ActiveSupport::JSON.decode(response.body)["story"]["id"]
    end

    it "should return unprocessable entity on unsuccessful creation" do
      skip("Working out authorization for this")
      set_member_user
      story = mock("story")
      Story.expects(:new).returns(story)
      story.expects(:save).returns(false)
      story.expects(:errors).returns({})
      post :create, {story_id: "this", format: 'json', story_section: {title: "Chapter 1"}}
      assert_response :unprocessable_entity
    end

  end

end