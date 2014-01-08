class StoriesController < ApplicationController

  def index
    @stories = Story.find_visible_for(current_user, search_parameters)

    respond_to do |format|
      format.html
      format.json { render json: @stories }
    end
  end

  def show
    @story = Story.find_visible_for(current_user, {:_slugs.in => [params[:id]]})

    respond_to do |format|
      if @story
        format.json{ render json: @story }
      else
        format.json{ render json: {}, status: :not_found}
      end

    end
  end

  def new

  end

  def create
    @story = Story.new(params[:story].merge(creator: current_user))

    respond_to do |format|
      if @story.save
        format.json { render json: @story, status: :ok }
      else
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit
    @story = Story.find(params[:id])

    respond_to do |format|
      format.json{ render json: @story }
    end
  end

  def update

    @story = Story.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.json { render json: @story, status: :ok }
      else
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def search_parameters
    search_params = {}
    creator = User.find_by_username(params[:username]) if params[:username]
    search_params[:creator] = creator if creator
    search_params
  end

  def current_resource
    @current_resource ||= Story.find(params[:id]) if params[:id]
  end

end