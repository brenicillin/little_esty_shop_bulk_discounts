class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :merchant_id
  validates_numericality_of :discount, :threshold, greater_than: 0
end