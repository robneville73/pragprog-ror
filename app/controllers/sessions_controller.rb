class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to (session[:intended_url] || user), notice: "Welcome back #{user.name}!"
            session[:intended_url] = nil
        else
            flash.now[:alert] = "Invalid username/password!"
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to movies_url, notice: "You're now logged out."
    end

end
