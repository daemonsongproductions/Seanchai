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

end