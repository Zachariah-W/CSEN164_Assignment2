class ProductsController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.order(:name)
    @products = Product.includes(:category, :reviews)
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
      @selected_category = Category.find_by(id: params[:category_id])
    end
    if params[:q].present?
      term = "%#{params[:q].to_s.strip}%"
      @products = @products.where("products.name LIKE ? OR products.description LIKE ?", term, term)
    end
    @products = @products.order(:name)
  end

  def show
    @reviews = @product.reviews.includes(:user).order(created_at: :desc)
    @review = Review.new
    @user_review = current_user ? @product.reviews.find_by(user_id: current_user.id) : nil
  end

  def new
    @product = Product.new
    @categories = Category.order(:name)
  end

  def create
    @product = Product.new(product_params)
    @categories = Category.order(:name)
    if @product.save
      redirect_to @product, notice: "Product added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @categories = Category.order(:name)
  end

  def update
    @categories = Category.order(:name)
    if @product.update(product_params)
      redirect_to @product, notice: "Product updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "Product removed."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id)
  end
end
