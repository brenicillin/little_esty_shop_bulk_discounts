class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  enum status: [:cancelled, 'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  
  def total_discount_amount
    discounted_items = invoice_items.map do |invoice_item|
      bulk_discount = invoice_item.item.merchant.bulk_discounts
      .order(discount: :desc)
      .first
      bulk_discount.present? ? (invoice_item.unit_price * invoice_item.quantity) * (bulk_discount.discount / 100.0) : 0
    end
    discounted_items.sum
  end
  
  def total_with_discount
    total_revenue - total_discount_amount
  end
end

# def total_with_discount
#   total = self.total_revenue
#   invoice_items.each do |item|
#     merchant = item.item.merchant
#     bulk_discount = merchant.bulk_discounts
#                             .where("threshold <= ?", item.quantity)
#                             .order(discount: :desc)
#                             .first
#     if bulk_discount.present?
#       discounted_amount = (item.unit_price * item.quantity) * (bulk_discount.discount / 100.0)
#       total -= discounted_amount
#     end
#   end
#   total
# end