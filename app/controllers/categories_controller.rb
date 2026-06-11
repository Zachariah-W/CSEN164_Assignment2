class CategoriesController < ApplicationController
  before_action :require_admin
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.includes(:products).order(:name)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "Category created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: "Category updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.products.any?
      redirect_to categories_path, alert: "Cannot delete a category that has products."
    else
      @category.destroy
      redirect_to categories_path, notice: "Category deleted."
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
