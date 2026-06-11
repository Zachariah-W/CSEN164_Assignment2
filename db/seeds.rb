Review.destroy_all
OrderItem.destroy_all
Order.destroy_all
LineItem.destroy_all
Cart.destroy_all
Product.destroy_all
Category.destroy_all
User.destroy_all

admin = User.create!(
  name: "Admin User",
  email: "admin@bluemarket.com",
  password: "password123",
  password_confirmation: "password123",
  admin: true
)

alice = User.create!(
  name: "Alice Chen",
  email: "alice@example.com",
  password: "password123",
  password_confirmation: "password123"
)

bob = User.create!(
  name: "Bob Martinez",
  email: "bob@example.com",
  password: "password123",
  password_confirmation: "password123"
)

electronics = Category.create!(name: "Electronics")
home = Category.create!(name: "Home")
books = Category.create!(name: "Books")

products_data = [
  { name: "Wireless Earbuds", description: "Lightweight earbuds with clear sound and a compact charging case.", price: 79.99, category: electronics },
  { name: "USB-C Hub", description: "Seven-port hub for laptops and tablets.", price: 45.00, category: electronics },
  { name: "Ceramic Mug Set", description: "Set of four matte mugs in soft blue tones.", price: 32.50, category: home },
  { name: "Desk Lamp", description: "Adjustable LED lamp with warm and cool modes.", price: 58.00, category: home },
  { name: "Rails Guide", description: "Practical guide to building web apps with Ruby on Rails.", price: 42.00, category: books },
  { name: "Design Systems", description: "How teams build consistent product interfaces.", price: 38.99, category: books }
]

products = products_data.map do |data|
  Product.create!(
    name: data[:name],
    description: data[:description],
    price: data[:price],
    category: data[:category]
  )
end

Review.create!(user: alice, product: products[0], rating: 5, comment: "Great sound for the price. Battery lasts all day.")
Review.create!(user: bob, product: products[0], rating: 4, comment: "Comfortable fit. Wish the case was a bit smaller.")
Review.create!(user: alice, product: products[2], rating: 5, comment: "Beautiful mugs. Exactly the color shown.")
Review.create!(user: bob, product: products[4], rating: 5, comment: "Clear explanations. Perfect for class.")

order1 = Order.create!(user: alice, total: 79.99, status: "placed")
OrderItem.create!(order: order1, product: products[0], quantity: 1, unit_price: products[0].price)

order2 = Order.create!(user: bob, total: 122.99, status: "placed")
OrderItem.create!(order: order2, product: products[4], quantity: 1, unit_price: products[4].price)
OrderItem.create!(order: order2, product: products[5], quantity: 2, unit_price: products[5].price)

puts "Seeded #{User.count} users, #{Category.count} categories, #{Product.count} products"
puts "Admin login: admin@bluemarket.com / password123"
puts "Sample user: alice@example.com / password123"
