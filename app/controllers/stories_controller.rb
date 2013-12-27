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

  def current_resource
    @current_resource ||= Story.find(params[:id]) if params[:id]
  end

end