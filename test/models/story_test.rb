require "test_helper"

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

end