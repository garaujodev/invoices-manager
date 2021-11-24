class User < ApplicationRecord
  has_many :invoices

  with_options presence: true do
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
    validates :token, uniqueness: true
  end
end
