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
    if true
      review = entity.reviews.build whitelist

      if review.save
        render json: review
      end
    else raise 'YOU CANNOT REVIEW YOUR OWN ENTITY!'
    end
  end

  def destroy
  end

  private
    def whitelist
      params.require(:review).permit(:score, :content, :reviewable_type, :reviewable_id)
    end
end
