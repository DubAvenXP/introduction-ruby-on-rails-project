class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  def index
    @users = User.all
    basic_response(@users, :ok)
  end

  def show
    basic_response(@user, :ok)
  end

  def create
    @user = User.new(user_params)
    @user.password = params[:password]
    basic_response(@user, :created, @user.save)
  end

  def update
    @user.password = params[:password]
    basic_response(@user, :ok, @user.update(user_params))
  end

  def destroy
    @user.destroy
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :role, :email, :password)
    end
end
