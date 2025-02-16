Item.destroy_all
Customer.destroy_all
Merchant.destroy_all
Invoice.destroy_all
InvoiceItem.destroy_all
Transaction.destroy_all
BulkDiscount.destroy_all

@merchant_1 = Merchant.create!(name: "Legolas' Lembas")
@merchant_2 = Merchant.create!(name: "Sauron's Mordor Mart")
@merchant_3 = Merchant.create!(name: "Bilbo's Burgers")
@merchant_4 = Merchant.create!(name: "Gandalf's Groomers")
@merchant_5 = Merchant.create!(name: "Frodo's Funhouse")

@item_1 = @merchant_1.items.create!(name: "Lembas", description: "Elvish Waybread", unit_price: 5)
@item_2 = @merchant_1.items.create!(name: "Bow", description: "Wooden Bow", unit_price: 10)
@item_3 = @merchant_2.items.create!(name: "Ring", description: "Evil Ring", unit_price: 1000000)
@item_4 = @merchant_3.items.create!(name: "Burger", description: "Tasty Burger", unit_price: 7)
@item_5 = @merchant_4.items.create!(name: "Shampoo", description: "For the hairy wizard", unit_price: 12)
@item_6 = @merchant_5.items.create!(name: "Funhouse", description: "Fun for the whole fellowship", unit_price: 1000000)
@item_7 = @merchant_5.items.create!(name: "Mithril", description: "Precious metal", unit_price: 500)
@item_8 = @merchant_5.items.create!(name: "The One Ring", description: "One ring to rule them all", unit_price: 1000000)

@customer_1 = Customer.create!(first_name: "Frodo", last_name: "Baggins")
@customer_2 = Customer.create!(first_name: "Samwise", last_name: "Gamgee")
@customer_3 = Customer.create!(first_name: "Gollum", last_name: "Shmeagol")
@customer_4 = Customer.create!(first_name: "Aragorn", last_name: "Elessar")

@invoice_1 = @customer_1.invoices.create!(status: 0)
@invoice_2 = @customer_2.invoices.create!(status: 0)
@invoice_3 = @customer_3.invoices.create!(status: 0)
@invoice_4 = @customer_4.invoices.create!(status: 0)

@invoice_item_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 10, unit_price: 5, status: 0)
@invoice_item_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 50, unit_price: 10, status: 0)
@invoice_item_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_2.id, quantity: 35, unit_price: 10, status: 0)
@invoice_item_4 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 5, unit_price: 1000000, status: 0)
@invoice_item_5 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_3.id, quantity: 1, unit_price: 1000000, status: 0)
@invoice_item_6 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_4.id, quantity: 23, unit_price: 7, status: 0)
@invoice_item_7 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 25, unit_price: 7, status: 0)
@invoice_item_8 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_5.id, quantity: 10, unit_price: 12, status: 0)

@transaction_1 = @invoice_1.transactions.create!(credit_card_number: 203942, credit_card_expiration_date: "", result: 0)
@transaction_2 = @invoice_2.transactions.create!(credit_card_number: 230948, credit_card_expiration_date: "", result: 0)
@transaction_3 = @invoice_3.transactions.create!(credit_card_number: 234092, credit_card_expiration_date: "", result: 0)
@transaction_4 = @invoice_4.transactions.create!(credit_card_number: 230429, credit_card_expiration_date: "", result: 0)

@bulk_discount_1 = BulkDiscount.create!(name: "Small Discount", discount: 5, threshold: 10, merchant_id: @merchant_1.id)
@bulk_discount_2 = BulkDiscount.create!(name: "Medium Discount", discount: 10, threshold: 20, merchant_id: @merchant_1.id)
@bulk_discount_3 = BulkDiscount.create!(name: "Large Discount", discount: 15, threshold: 30, merchant_id: @merchant_1.id)
@bulk_discount_4 = BulkDiscount.create!(name: "Small Discount", discount: 5, threshold: 10, merchant_id: @merchant_2.id)
@bulk_discount_5 = BulkDiscount.create!(name: "Medium Discount", discount: 10, threshold: 20, merchant_id: @merchant_2.id)
@bulk_discount_6 = BulkDiscount.create!(name: "Large Discount", discount: 15, threshold: 30, merchant_id: @merchant_2.id)
@bulk_discount_7 = BulkDiscount.create!(name: "Small Discount", discount: 5, threshold: 10, merchant_id: @merchant_3.id)
@bulk_discount_8 = BulkDiscount.create!(name: "Medium Discount", discount: 10, threshold: 20, merchant_id: @merchant_3.id)
@bulk_discount_9 = BulkDiscount.create!(name: "Large Discount", discount: 15, threshold: 30, merchant_id: @merchant_3.id)