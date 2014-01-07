class StorySectionsController < ApplicationController

  def new
    @story = Story.find(params[:story_id])

    respond_to do |format|
      if @story
        format.json{ render json: @story }
      else
        format.json{ render json: {}, status: :not_found}
      end
    end

  end

  def create
    @story = Story.find(params[:story_id])

    respond_to do |format|
      if @story
        format.json{ render json: @story }
      else
        format.json{ render json: {}, status: :not_found}
      end
    end
  end

  private

  def current_resource
    #@current_resource ||= StorySection.find_visible_for(current_user, {:_slugs.in => [params[:id]]}) if params[:id]
    if params[:id]
      @current_resource ||= StorySection.find(params[:id])
    elsif params[:story_id]
      @current_resource ||= Story.find(params[:story_id]) if params[:story_id]
    end
  end

end