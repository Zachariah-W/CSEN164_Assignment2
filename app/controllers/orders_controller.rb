class OrdersController < ApplicationController
  before_action :require_login, except: []
  before_action :set_order, only: [:show]

  def index
    if current_user.admin?
      @orders = Order.includes(:user, :order_items).order(created_at: :desc)
    else
      @orders = current_user.orders.includes(:order_items).order(created_at: :desc)
    end
  end

  def show
    unless current_user.admin? || @order.user_id == current_user.id
      flash[:alert] = "You cannot view this order."
      redirect_to orders_path
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
