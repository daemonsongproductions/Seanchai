require "test_helper"
require "factory_girl"

class StoryTest < MiniTest::Unit::TestCase

  def test_sanity
    skip("leaving this as an example of unit test syntax in minitest")
  end

end

describe "Story" do


  describe "friendly paths" do

    it "should generate a friendly slug out of the title" do

      story = FactoryGirl.build(:story)
      story.save

      assert_equal "title-of-my-story", story.slug
    end

    it "should increment a number for the friendly path if the generated path is already taken" do

      story_1 = FactoryGirl.build(:story)
      story_1.save
      story_2 = FactoryGirl.build(:story)
      story_2.save

      assert_equal "title-of-my-story-1", story_2.slug
    end

  end

  describe "status" do

    it "should have draft as its default status" do
      story = FactoryGirl.build(:story)
      assert_equal Status[:draft].id, story.status_id
    end

    it "should save the supplied status_id" do
      story = FactoryGirl.build(:story, status_id: Status[:published].id)
      assert_equal Status[:published].id, story.status_id
    end

    it "should save the supplies status" do
      story = FactoryGirl.build(:story, status: Status[:published])
      assert_equal Status[:published].id, story.status_id
    end

    it "should validate the status_id is valid" do
      story = FactoryGirl.build(:story, status_id: 100000)
      story.save
      assert_equal 1, story.errors.count
      assert_equal [:status_id, "is not included in the list"], story.errors.first
    end

  end

  describe "querying" do

    describe "find_visible_for" do

      before :each do
        @user = FactoryGirl.create(:user)
        @creator_1 = FactoryGirl.create(:user, username: "user2", email: "user2@user.com")
        @creator_2 = FactoryGirl.create(:user, username: "user3", email: "user3@user.com")

        @story_1 = FactoryGirl.build(:story, {title: "Title 1", creator: @creator_1})
        @story_1.save
        @story_2 = FactoryGirl.build(:story, {title: "Title 2", status: Status[:published], creator: @creator_1})
        @story_2.save

        @story_3 = FactoryGirl.build(:story, {title: "Title 3",  creator: @creator_2})
        @story_3.save
        @story_4 = FactoryGirl.build(:story, {title: "Title 4", status: Status[:published], creator: @creator_2})
        @story_4.save

      end

      it "should return only published stories for non-creators" do
        results = Story.find_visible_for(@user)
        assert_equal 2, results.count
      end

      it "should only return other statuses for the creator" do
        results = Story.find_visible_for(@creator_1)
        assert_equal 3, results.count
      end

      it "should any other search criteria passed" do
        creator_results = Story.find_visible_for(@creator_1, {title: "Title 1"})
        non_creator_results = Story.find_visible_for(@creator_1, {title: "Title 3"})
        assert_equal 1, creator_results.count
        assert_equal nil, non_creator_results
      end
    end

  end

  describe "Story Sections" do

    it "should return story sections in Order Ascending" do

      story = FactoryGirl.create(:story, title: "Story")
      section_1 =story.story_sections.create(title: "Chapter 2")
      section_2 = story.story_sections.create(title: "Chapter 3")
      section_3 = story.story_sections.create(title: "Chapter 1")

      section_3.move_to :top
      section_3.save

      story_sections = story.story_sections
      assert_equal "Chapter 1", story_sections.first.title
      assert_equal "Chapter 2", story_sections.second.title
      assert_equal "Chapter 3", story_sections.third.title

    end

  end

end