class AdminController < ApplicationController
  layout 'admin'
  before_filter {:requires_login}

  def index
    
  end

end
