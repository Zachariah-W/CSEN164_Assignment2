class LineItemsController < ApplicationController
  def create
    product = Product.find(params[:id] || params[:product_id])
    cart = current_cart
    item = cart.line_items.find_by(product_id: product.id)
    if item
      item.quantity += 1
      item.save
    else
      cart.line_items.create!(product: product, quantity: 1)
    end
    redirect_to product_path(product), notice: "Added to cart."
  end

  def update
    item = current_cart.line_items.find(params[:id])
    qty = params[:line_item][:quantity].to_i
    if qty < 1
      item.destroy
    else
      item.update(quantity: qty)
    end
    redirect_to cart_path
  end

  def destroy
    item = current_cart.line_items.find(params[:id])
    item.destroy
    redirect_to cart_path, notice: "Item removed."
  end
end
