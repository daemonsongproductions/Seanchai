class StorySectionsController < ApplicationController

  def index
    @story_sections = section_search

    respond_to do |format|
      if @story_sections
        format.json{ render json: @story_sections }
      else
        format.json{ render json: {}, status: :not_found}
      end
    end
  end

  def show
    @story_section = StorySection.find(params[:id])
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

  def section_search
    if params[:ids]
      StorySection.any_in(:id => params[:ids])
    else
      search_parameters = {}
      search_parameters[:story] = Story.find(params[:story_id]) if params[:story_id]
      search_parameters[:order] = params[:order] if params[:order]
      search_parameters.merge!(:_slugs.in => [params[:id]]) if params[:id]
      StorySection.where(search_parameters) if search_parameters[:story]
    end

  end

  def current_resource
    if params[:story_id]
      @current_resource ||= Story.find(params[:story_id])
    elsif params[:story_section] && params[:story_section][:story_id]
      @current_resource ||= Story.find(params[:story_section][:story_id])
    end
  end

end