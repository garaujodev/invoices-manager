class Invoice < ApplicationRecord
  has_many :emails

  belongs_to :user

  with_options presence: true do
    validates :number
    validates :due_at
    validates :bill_from
    validates :bill_to
    validates :total, numericality: true
  end
end
