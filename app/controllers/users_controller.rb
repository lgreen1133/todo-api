class UsersController < ApplicationController
  def index
    @users = User.all 
  end

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      flash[:notice] = "User saved successfully"
      redirect_to root_path
    else
      flash[:error] = "There was an error. Try again."
      render :new
    end

  end

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User updated successfully"
    else
      flash[:error] = "Invalid user information"
    end
    redirect_to edit_user_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
