class ProfileController < ApplicationController

  # GET
  def show
    
  end

  # GET /profile/edit
  def edit
    
  end

  # GET /profile/new
  def new
    @user = User.new
  end

  # POST /profile
  def create
    @user = User.new
    @user.email = params[:email]
    @user.password = params[:password]

    successful = @user.save unless params[:password]!= params[:confirm_password]

    if successful
      flash[:notice] = "Your profile has been created."
      redirect_to show_profile_path
    else
      flash[:error] = "Sorry, we couldn't create your profile. Try again."
      redirect_to new_profile_path
    end
    
  end

  # PUT /profile
  def update
    
  end

end
