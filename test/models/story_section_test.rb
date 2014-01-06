require "test_helper"
require "factory_girl"

describe "StorySection" do

  describe "StorySection fields" do
    it "should have needed fields" do
      StorySection.must have_field(:title)
      StorySection.must have_field(:include_in_toc)
      StorySection.must have_field(:body)
      StorySection.must have_field(:publication_date)
      StorySection.must have_field(:meta)
      StorySection.must have_field(:status_id)
      StorySection.must have_field(:order)
    end
  end

  describe "Story associations" do

    it "should belong to a story" do
      StorySection.must belong_to(:story)
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

end