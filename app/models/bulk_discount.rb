class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name, :merchant_id
  validates_numericality_of :discount, :threshold, greater_than: 0
end