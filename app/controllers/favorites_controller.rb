class FavoritesController < ApplicationController

    before_action :require_signin
    before_action :find_movie

    def create
        @movie.favorites.create!(user: current_user)
        redirect_to @movie
    end

    def destroy
        user_already_faved?(@movie, current_user).destroy
        redirect_to @movie
    end

private

    def find_movie
        @movie = Movie.find_by!(slug: params[:movie_id])
    end

end
