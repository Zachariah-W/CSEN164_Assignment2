class HomeController < ApplicationController
  def index
    @products = Product.includes(:category).order(created_at: :desc).limit(6)
    @categories = Category.order(:name)
  end
end
