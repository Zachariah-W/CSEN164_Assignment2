# Online Store (Option A)

CSEN 164 Assignment #2

## Project description

Shoppers can browse and filter products, add items from the product detail page, check out when logged in, and manage their order history. Registered users can post product reviews. Admins manage products, categories, and view every order.

## Main features

- **Add to Cart** on each product detail page
- **User accounts** — sign up, log in, log out, session-based auth (`has_secure_password`)
- **Order history** — orders belong to users; users see only their orders; admins see all orders
- **Product reviews** — rating (1–5) and comment; average rating on product pages; users edit/delete only their own reviews
- **Categories & filtering** — products belong to categories; browse by category; search/filter on the shop index (name + category)
- **Admin tools** — full CRUD for products and categories

## Models and associations

| Model     | Associations                                                        |
| --------- | ------------------------------------------------------------------- |
| User      | `has_many :orders`, `has_many :reviews`                             |
| Order     | `belongs_to :user`, `has_many :order_items`                         |
| Product   | `belongs_to :category`, `has_many :reviews`, `has_many :line_items` |
| Category  | `has_many :products`                                                |
| Cart      | `has_many :line_items` (session-based via `session_id`)             |
| LineItem  | `belongs_to :cart`, `belongs_to :product`                           |
| OrderItem | `belongs_to :order`, `belongs_to :product`                          |
| Review    | `belongs_to :user`, `belongs_to :product`                           |

## How to run the application

Visit: [http://18.188.154.85:3000/](http://18.188.154.85:3000/)

Use the sample accounts below to log in.

## Sample logins

| Role  | Email                | Password    |
| ----- | -------------------- | ----------- |
| Admin | admin@bluemarket.com | password123 |
| User  | alice@example.com    | password123 |
| User  | bob@example.com      | password123 |

## Known limitations

- Cart is tied to the browser session, not merged when a user logs in
- No payment processing — checkout creates an order record only
- Product images are not included
- Search uses simpl SQL `LIKE` matching
