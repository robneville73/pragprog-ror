class MoviesController < ApplicationController

    before_action :require_signin, except: [:index, :show]
    before_action :require_admin, except: [:index, :show]
    before_action :fetch_movie, except: [:index, :new, :create]

    def index
        @movies = Movie.released
    end

    def show
        @review = @movie.reviews.new
        @fans = @movie.fans
        @genres = @movie.genres
    end

    def edit
    end

    def update
        if @movie.update(movie_params)
            redirect_to @movie, notice: "Movie successfully updated!" 
        else
            render :edit
        end
    end

    def new
        @movie = Movie.new
    end

    def create
        @movie = Movie.new(movie_params)
        if @movie.save
            redirect_to @movie, notice: "Movie successfully created!"
        else
            render :new
        end
    end

    def destroy
        @movie.destroy
        redirect_to movies_url, alert: "Movie deleted!"
    end

private

    def fetch_movie
        @movie = Movie.find(params[:id])
    end

    def movie_params
        params.require(:movie).permit(:title,:description,:rating,:released_on,:total_gross,
                                      :director, :duration, :image_file_name, genre_ids:[])
    end
end
