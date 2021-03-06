class UsersController < ApplicationController
  layout 'form', only: [:new]
  skip_before_filter :require_login, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User created!'
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @upcoming_events =  @user.upcoming_events
    @past_events = @user.past_events
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
