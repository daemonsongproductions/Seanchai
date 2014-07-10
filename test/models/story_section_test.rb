require "test_helper"
require "factory_girl"

describe "StorySection" do

  describe "friendly paths" do

    it "should generate a friendly slug out of the title" do

      section = FactoryGirl.build(:story_section, title: "Chapter 1")
      section.save

      assert_equal "chapter-1", section.slug
    end

    it "should increment a number for the friendly path if the generated path is already taken" do

      story = FactoryGirl.create(:story, title: "Story 1")
      section_1 = FactoryGirl.build(:story_section, {title: "Chapter 1", story: story})
      section_1.save
      section_2 = FactoryGirl.build(:story_section, {title: "Chapter 1", story: story})
      section_2.save

      assert_equal "chapter-1-1", section_2.slug
    end

    it "should scope friendly paths by story" do

      story_1 = FactoryGirl.create(:story, title: "Story 1")
      story_2 = FactoryGirl.create(:story, title: "Story 2")

      section_1 = FactoryGirl.build(:story_section, {title: "Chapter 2", story: story_1})
      section_1.save
      section_2 = FactoryGirl.build(:story_section, {title: "Chapter 2", story: story_1})
      section_2.save
      section_3 = FactoryGirl.build(:story_section, {title: "Chapter 2", story: story_2})
      section_3.save

      assert_equal "chapter-2-1", section_2.slug
      assert_equal "chapter-2", section_3.slug

    end

  end

  describe "order" do

    it "should scope order by story" do
      story_1 = FactoryGirl.create(:story, title: "Story 1")
      story_2 = FactoryGirl.create(:story, title: "Story 2")
      section_1 = FactoryGirl.create(:story_section, {title: "Chapter 2", story: story_1})
      section_2 = FactoryGirl.create(:story_section, {title: "Chapter 2", story: story_1})
      section_3 = FactoryGirl.create(:story_section, {title: "Chapter 2", story: story_2})
      section_4 = FactoryGirl.create(:story_section, {title: "Chapter 2", story: story_2})

      assert_equal 1, section_1.order
      assert_equal 2, section_2.order
      assert_equal 1, section_3.order
      assert_equal 2, section_4.order

    end

  end

  describe "status" do

    it "should have draft as its default status" do
      section = FactoryGirl.build(:story_section)
      assert_equal Status[:draft].id, section.status_id
    end

    it "should save the supplied status_id" do
      section = FactoryGirl.build(:story_section, status_id: Status[:published].id)
      assert_equal Status[:published].id, section.status_id
    end

    it "should save the supplies status" do
      section = FactoryGirl.build(:story_section, status: Status[:published])
      assert_equal Status[:published].id, section.status_id
    end

    it "should validate the status_id is valid" do
      section = FactoryGirl.build(:story_section, status_id: 100000)
      section.save
      assert_equal 1, section.errors.count
      assert_equal [:status_id, "is not included in the list"], section.errors.first
    end

  end

  describe "querying" do

    describe "find_visible_for" do

      before :each do
        @user = FactoryGirl.create(:user)
        @creator_1 = FactoryGirl.create(:user, username: "user2", email: "user2@user.com")
        @creator_2 = FactoryGirl.create(:user, username: "user3", email: "user3@user.com")

        @story_1 = FactoryGirl.create(:story, {title: "Title 1", creator: @creator_1})
        @section_1 = FactoryGirl.create(:story_section, {title: "Chapter 1", story: @story_1, status: Status.published})
        @section_2 = FactoryGirl.create(:story_section, {title: "Chapter 2", story: @story_1})

        @story_2 = FactoryGirl.create(:story, {title: "Title 2", status: Status[:published], creator: @creator_2})
        @section_3 = FactoryGirl.create(:story_section, {title: "Chapter 1", story: @story_2, status: Status.published})
        @section_4 = FactoryGirl.create(:story_section, {title: "Chapter 2", story: @story_2})

        @story_3 = FactoryGirl.create(:story, {title: "Title 3",  creator: @creator_1})
        @section_5 = FactoryGirl.create(:story_section, {title: "Chapter 2", story: @story_3, status: Status.published})
        @section_6 = FactoryGirl.create(:story_section, {title: "Chapter 2", story: @story_3})

        @story_4 = FactoryGirl.build(:story, {title: "Title 4", status: Status[:published], creator: @creator_2})
        @section_7 = FactoryGirl.create(:story_section, {title: "Chapter 2", story: @story_4, status: Status.published})
        @section_8 = FactoryGirl.create(:story_section, {title: "Chapter 2", story: @story_4})

      end

      it "should return only published stories for non-creators" do
        results = StorySection.find_visible_for(@user)
        assert_equal 4, results.count
      end

      it "should only return other statuses for the creator" do
        results = StorySection.find_visible_for(@creator_1)
        assert_equal 6, results.count
      end

      it "should search by any other search criteria passed" do
        creator_results = StorySection.find_visible_for(@creator_1, {id: @section_2.id})
        non_creator_results = StorySection.find_visible_for(@creator_1, {id: @section_4.id})
        assert_equal 1, creator_results.count
        assert_equal 0, non_creator_results.count
      end
    end

  end

end