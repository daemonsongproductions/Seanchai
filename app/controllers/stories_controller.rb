class StoriesController < ApplicationController

  def index
    @stories = Story.all

    respond_to do |format|
      format.html
      format.json { render json: @stories }
    end
  end

  def show

    @story = Story.find(params[:id])

    respond_to do |format|
      format.json{ render json: @story }
    end

  end

  def new

  end

  def create
    @story = Story.new(story_params.merge(creator: current_user))

    respond_to do |format|
      if @story.save
        format.json { render json: @story, status: :ok }
      else
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit

  end

  def update


    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.json { render json: nil, status: :ok }
      else
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Using a private method to encapsulate the permissible parameters is just a good pattern
  # since you'll be able to reuse the same permit list between create and update. Also, you
  # can specialize this method with per-user checking of permissible attributes.
  def story_params
    params.require(:story).permit(:title, :creator, :description, :copyright)
  end

end