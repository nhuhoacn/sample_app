class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".user_not_found"
    redirect_to signup_url
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".users_success"
      redirect_to @user
    else
      flash[:danger] = t ".users_unsuccess"
      render :new
    end
  end

  def destroy; end

  private
  def user_params
    params.require(:user).permit User::USER_ATTRIBUTES
  end
end
