class UsersController < ApplicationController

    before_action :require_signin, except: [:new, :create]
    before_action :require_correct_user, only: [:edit, :update]
    before_action :require_admin, only: [:destroy]

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        @favorite_movies = @user.favorite_movies
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user, notice: "Account created!"
        else
            render :new
        end
    end

    def edit
    end

    def update
        @user.update(user_params)
        if @user.save
            redirect_to @user, notice: "Account updated!"
        else
            render :edit
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        session[:user_id] = nil
    end

private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :username)
    end

    def require_correct_user
        @user = User.find(params[:id])
        unless current_user?(@user)
            redirect_to root_url
        end
    end

end
