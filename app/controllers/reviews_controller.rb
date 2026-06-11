class ReviewsController < ApplicationController
  before_action :require_login
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :authorize_review, only: [:edit, :update, :destroy]

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.build(review_params.merge(user: current_user))
    if @review.save
      redirect_to @product, notice: "Review posted."
    else
      redirect_to @product, alert: @review.errors.full_messages.to_sentence
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to @review.product, notice: "Review updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    product = @review.product
    @review.destroy
    redirect_to product_path(product), notice: "Review deleted."
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def authorize_review
    unless @review.user_id == current_user.id
      flash[:alert] = "You can only edit your own reviews."
      redirect_to @review.product
    end
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
