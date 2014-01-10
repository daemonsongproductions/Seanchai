class StorySectionsController < ApplicationController

  def index
    @story = params[:story_id] ?  Story.find(params[:story_id]) : nil

    respond_to do |format|
      if @story
        format.json{ render json: @story.story_sections }
      else
        format.json{ render json: {}, status: :not_found}
      end
    end
  end

  def show
    @story = params[:story_id] ?  Story.find(params[:story_id]) : nil
    @story_section = @story.story_sections.find(params[:id]) if @story
    respond_to do |format|
      if @story_section
        format.json{ render json: @story_section }
      else
        format.json{ render json: {}, status: :not_found}
      end
    end
  end

  def new
    @story = Story.find(params[:story_section][:story_id])

    respond_to do |format|
      if @story
        format.json{ render json: @story }
      else
        format.json{ render json: {}, status: :not_found}
      end
    end

  end

  def create
    @story_section = StorySection.new(params[:story_section])
    respond_to do |format|
      if @story_section.save
        format.json{ render json: @story_section }
      else
        format.json{ render json: {}, status: :unprocessable_entity}
      end
    end
  end

  private

  def current_resource
    if params[:id]
      @current_resource ||= StorySection.find(params[:id])
    elsif params[:story_section] && params[:story_section][:story_id]
      @current_resource ||= Story.find(params[:story_section][:story_id])
    elsif params[:story_id]
      @current_resource ||= Story.find([:story_id])
    end
  end

end