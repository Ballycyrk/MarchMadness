class PasswordResetsController < ApplicationController
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent, don't screw it up this time."
      redirect_to root_url
    else
      flash.now[:danger] = "Ain't no email here by that name."
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      flash[:danger] = "Seriously?  Try actually typing a new password."
      render 'edit'
    elsif @user.update_attributes(users_params)
      log_in @user
      flash[:success] = "Well done, password reset."
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def users_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
       @user = User.find_by(email: params[:email])
    end

    # Confirms a valid user
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    # Check expiration of reset token.
    def check_expiration
      if @user.password_reset_expired?
        message =  "Where have you've been for the last two hours? "
        message += " You're reset request has expired."
        flash[:danger] = message
        redirect_to new_password_reset_url
      end
    end
end
