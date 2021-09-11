class ReviewsController < ApplicationController

    before_action :set_movie
    before_action :set_intended_url, only: [:create]
    before_action :require_signin, except: [:index]

    def index
        @reviews = @movie.reviews
    end

    def new
        @review = @movie.reviews.new
    end

    def create
        @review = @movie.reviews.new(review_params)
        @review.user = current_user
        if @review.save
            redirect_to movie_url(@movie), notice: "Thanks for the review!"
        else
            render :new
        end 
    end

    def edit
        @review = @movie.reviews.find(params[:id])
    end

    def update
        @review = @movie.reviews.find(params[:id])
        @review.update(review_params)
        if @review.save
            redirect_to movie_reviews_url(@movie), notice: "Review edited."
        else
            render :edit
        end
    end

    def destroy
        @review = @movie.reviews.find(params[:id])
        @review.destroy
        redirect_to movie_reviews_url(@movie), notice: "Review deleted."
    end

private

    def review_params
        params.require(:review).permit(:stars, :comment)
    end

    def set_movie
        @movie = Movie.find(params[:movie_id])
    end

    def set_intended_url
        session[:intended_url] = movie_path @movie
    end

end
