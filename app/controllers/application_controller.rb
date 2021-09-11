class ApplicationController < ActionController::Base

private

    def current_user?(user)
        current_user == user
    end

    def require_signin
        unless current_user
            session[:intended_url] = session[:intended_url] || request.url
            redirect_to new_session_url, alert: "Please sign in first!"
        end
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def require_admin
        unless current_user_admin?
            redirect_to root_url, alert: "Unauthroized access!"
        end
    end

    def current_user_admin?
        current_user && current_user.admin?
    end

    helper_method :current_user

    helper_method :current_user?

    helper_method :current_user_admin?
end
