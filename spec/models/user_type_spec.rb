require 'spec_helper'

describe UserType do

  fixtures :user_types

  describe "Defined Types" do

    it "should find the user type named 'author' when UserType.author is called" do
      UserType.should_receive(:find_by_name).with('author')
      UserType.author
  
    end

    it "should find the user type 'reader' when UserType.reader is called" do
      UserType.should_receive(:find_by_name).with('reader')
      UserType.reader
    end

  end

end