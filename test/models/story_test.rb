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
      Story.must have_field(:permalink)
    end
  end

  describe "Story associations" do

    it "should belong to a creator" do
      Story.must belong_to(:creator)
    end
  end

  describe "friendly paths" do

    before :each do
      @story = FactoryGirl.build(:story)
    end

    it "should generate a friendly path out of the title" do
      assert_equal "title-of-my-story", @story.permalink

    end

    it "should increment a number for the friendly path if the generated path is already taken"

    it "should override the id with the permalink"

    it "should recover from a permalink validation failure by incrementing and trying again"

  end

end