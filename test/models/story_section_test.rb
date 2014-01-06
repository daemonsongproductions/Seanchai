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

end