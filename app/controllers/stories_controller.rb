class StoriesController < ApplicationController

  def index
    @stories = Story.all

    respond_to do |format|
      format.html
      format.json { render json: @stories }
    end
  end

  def show

  end

  def new

  end

  def create



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

end