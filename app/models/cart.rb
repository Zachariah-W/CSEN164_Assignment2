class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  validates :session_id, presence: true, uniqueness: true

  def total
    line_items.includes(:product).sum { |item| item.product.price * item.quantity }
  end

  def item_count
    line_items.sum(:quantity)
  end
end
