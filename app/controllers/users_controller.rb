class UsersController < ApplicationController

  before_action :set_user, only:[:edit, :update]
  
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

end