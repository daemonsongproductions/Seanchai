class StatusesController < ApplicationController

  def index
    respond_to do |format|
      format.json {render json: Status.find_all}
    end
  end

end