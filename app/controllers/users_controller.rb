class UsersController < Devise::SessionsController

  def show
    @user = User.find_by_username(params[:username])
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def edit
    @user = User.find_by_username(params[:username])
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def update

  end


  def get_current_user
    respond_to do |format|
      format.json { render json: [current_user], root: 'current_user' }
    end
  end

end