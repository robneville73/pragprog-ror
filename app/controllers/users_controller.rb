class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
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
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
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
        redirect_to movies_url, alert: "Account deleted"
    end

private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :username)
    end

end