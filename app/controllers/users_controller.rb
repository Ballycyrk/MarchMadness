class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :followers, :following]
  before_action :authorize,      only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] =
            "Steady your resolve, check your email and activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Updated, I hope you're happy."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Done and buried."
    redirect_to users_url
  end

  def following
    @title = "Heretics"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Disciples"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

private

    def user_params
      params.require(:user).permit(:handle, :first_name, :last_name, :email,
                                   :password, :password_confirmation)
    end

    #Before filters

    # Authenticates Users credentials
    def authorize
      @user = User.find(params[:id])
      if current_user?(@user)
        @user = User.find(params[:id])
      else
        flash[:danger] = "That ain't cool."
        redirect_to root_url
      end
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def create_activation_digest
    end
end
