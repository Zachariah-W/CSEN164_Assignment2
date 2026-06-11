module ApplicationHelper
  def format_price(amount)
    number_to_currency(amount)
  end

  def star_display(rating)
    full = rating.to_i
    empty = 5 - full
    ("★" * full) + ("☆" * empty)
  end
end
