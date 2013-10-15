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
    @user = User.find_by_username(params[:username])
    user_params = params["user"].symbolize_keys

    respond_to do |format|
      if @user.update_attributes(name: user_params[:name], email: user_params[:email])
        format.json { render json: @user }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => {error_message: "We had a problem saving this user. Please be sure all required fields are complete."}, :status => :unprocessable_entity }
      end
    end

  end


  def show_current_user
    respond_to do |format|
      format.json { render json: current_user, root: 'user' }
    end
  end

  private

  def current_resource
    @current_resource ||= User.find_by_username(params[:username]) if params[:username]
  end

end