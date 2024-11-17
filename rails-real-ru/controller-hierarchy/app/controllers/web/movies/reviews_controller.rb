module Web::Movies
  class ReviewsController < ApplicationController
    def index
      @reviews = resource_movie.reviews.order(id: :desc)
    end

    def new
      @review = resource_movie.reviews.build
    end

    def edit
      @review = Review.find params[:id]
    end

    def create
      @review = resource_movie.reviews.build(permitted_reviews_params)

      if @review.save
        redirect_to movie_reviews_path(resource_movie), notice: t('success')
      else
        flash[:alert] = t('fail')
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @review = Review.find params[:id]

      if @review.update(permitted_reviews_params)
        redirect_to movie_reviews_path(resource_movie), notice: t('success')
      else
        flash[:alert] = t('fail')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @review = Review.find params[:id]

      @review&.destroy!

      redirect_to movie_reviews_path(resource_movie), notice: t('.success')
    end

    private

    def permitted_reviews_params
      params.require(:review).permit(:body)
    end
  end
end