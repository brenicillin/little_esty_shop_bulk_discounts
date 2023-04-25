require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many :transactions}
    it { should have_many :invoice_items}
  end

  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Aragorns Armor and Arms')
    @item_1 = Item.create!(name: "Longsword", description: "One sword to rule them all", unit_price: 100, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Bow", description: "One bow to rule them all", unit_price: 100, merchant_id: @merchant_1.id)
    @customer_1 = Customer.create!(first_name: 'Bilbo', last_name: 'Baggins')
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 10, unit_price: 100, status: 2)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 10, unit_price: 100, status: 2)
    @discount_1 = @merchant_1.bulk_discounts.create!(name: "Half off!", discount: 50, threshold: 10)
  end

  describe "instance methods" do
    it "total_revenue" do
      expect(@invoice_1.total_revenue).to eq(2000.0)
    end

    it "total_discount_amount" do
      expect(@invoice_1.total_discount_amount).to eq(1000.0)

      @discount_1 = @merchant_1.bulk_discounts.create!(name: "Mordor Fire Sale", discount: 75, threshold: 10)

      expect(@invoice_1.total_discount_amount).to eq(1500.0)
    end

    it 'total_with_discount' do
      expect(@invoice_1.total_with_discount).to eq(1000)

      @discount_1 = @merchant_1.bulk_discounts.create!(name: "Mordor Fire Sale", discount: 75, threshold: 10)

      expect(@invoice_1.total_with_discount).to eq(500.0)
    end
  end
end
