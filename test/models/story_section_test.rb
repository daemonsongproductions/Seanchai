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

end