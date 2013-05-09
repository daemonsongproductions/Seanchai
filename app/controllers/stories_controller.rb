class StoriesController < ApplicationController

  def index
    @stories = Story.all
  end

end