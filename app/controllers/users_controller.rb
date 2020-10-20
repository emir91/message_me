class UsersController < ApplicationController

  before_action :set_user, only:[:show, :edit, :update]
  before_action :require_user, only:[:edit, :show]
  before_action :require_same_user, only:[:show, :edit, :update]
  
  
    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = 'Welcome to Message Me, you have successfully signed up.'
        redirect_to root_path
      else
        render 'new'
      end
    end

    def show
    end

    def edit
    end

    def update
      if @user.update(user_params)
        flash[:notice] = "Profile successfully updated"
        redirect_to @user
      else
        render 'edit'
      end
    end

    private

    def user_params
     params.require(:user).permit(:email,:username,:password)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_same_user
     if current_user != @user
      flash[:notice] = 'You can only view and edit your profile'
      redirect_to user_path(current_user)
     end 
    end

end