class CartsController < ApplicationController
  def show
    @cart = current_cart
    @line_items = @cart.line_items.includes(:product)
  end

  def checkout
    require_login
    return if performed?

    cart = current_cart
    if cart.line_items.empty?
      redirect_to cart_path, alert: "Your cart is empty."
      return
    end

    order = Order.new(user: current_user, total: cart.total, status: "placed")
    Order.transaction do
      order.save!
      cart.line_items.each do |item|
        order.order_items.create!(
          product: item.product,
          quantity: item.quantity,
          unit_price: item.product.price
        )
      end
      cart.line_items.destroy_all
    end
    redirect_to order_path(order), notice: "Order placed successfully."
  rescue ActiveRecord::RecordInvalid
    redirect_to cart_path, alert: "Checkout failed. Please try again."
  end
end
