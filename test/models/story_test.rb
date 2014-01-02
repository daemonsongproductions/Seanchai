require "test_helper"
require "factory_girl"

class StoryTest < MiniTest::Unit::TestCase
  include Mongoid::Matchers

  def test_sanity
    skip("leaving this as an example of unit test syntax in minitest")
  end

end

describe "Story" do

  describe "Story fields" do
    it "should have needed fields" do
      Story.must have_field(:title)
      Story.must have_field(:copyright)
      Story.must have_field(:license)
      Story.must have_field(:description)
      Story.must have_field(:publication_date)
      Story.must have_field(:meta)
      Story.must have_field(:status_id)
    end
  end

  describe "Story associations" do

    it "should belong to a creator" do
      Story.must belong_to(:creator)
    end
  end

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

end