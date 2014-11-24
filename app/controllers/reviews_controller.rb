class ReviewsController < ApplicationController
  
  def index
    render json: entity.reviews
  end

  def show
  end

  def edit
  end

  def update
  end

  def create
    review = entity.reviews.build whitelist.merge({:user_id => current_user.id})

    if review.save
      render json: review
    end
  end

  def destroy
  end

  private
    def whitelist
      params.require(:review).permit(:score, :content)
    end
end
