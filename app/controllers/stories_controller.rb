class StoriesController < ApplicationController

  def index
    @stories = Story.find_visible_for(current_user, search_criteria, search_options)

    respond_to do |format|
      if @stories
        format.json { render json: @stories }
      else
        format.json { render json: [] }
      end

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

  def search_criteria
    criteria = {}
    creator = User.find_by_username(params[:username]) if params[:username]
    criteria[:creator] = creator if creator
    criteria
  end

  def search_options
    options = {}
    options[:order_by] = sort_parameters
    options[:limit] = params[:limit] ? params[:limit] : 10
    options[:skip] = params[:skip] ? params[:skip] : 0
    options
  end

  def sort_parameters
    direction = params[:direction] ? params[:direction] : 'asc'
    params[:order_by] ? { params[:order_by] => direction } : {title: order}
  end

  def current_resource
    @current_resource ||= Story.find(params[:id]) if params[:id]
  end

end