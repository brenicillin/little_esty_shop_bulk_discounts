require 'rails_helper'

RSpec.describe 'Bulk Discount Index Page' do
  before(:each) do
    @merchant = Merchant.create!(name: 'Merchant 1')
    @discount_1 = BulkDiscount.create!(name: 'Discount 1', merchant_id: @merchant.id, threshold: 10, discount: 20)
    @discount_2 = BulkDiscount.create!(name: 'Discount 2', merchant_id: @merchant.id, threshold: 30, discount: 40)
  end

  describe 'Bulk discount show page' do
    it 'lists information about the discount' do
      visit merchant_bulk_discount_path(@merchant, @discount_1)

      expect(page).to have_content(@discount_1.name)
      expect(page).to have_content(@discount_1.discount)
      expect(page).to have_content(@discount_1.threshold)
      expect(page).to_not have_content(@discount_2.name)
      expect(page).to_not have_content(@discount_2.discount)
      expect(page).to_not have_content(@discount_2.threshold)

      visit merchant_bulk_discount_path(@merchant, @discount_2)

      expect(page).to have_content(@discount_2.name)
      expect(page).to have_content(@discount_2.discount)
      expect(page).to have_content(@discount_2.threshold)
      expect(page).to_not have_content(@discount_1.name)
      expect(page).to_not have_content(@discount_1.discount)
      expect(page).to_not have_content(@discount_1.threshold)
    end
  end

  it 'has a link to edit the discount' do
    visit merchant_bulk_discount_path(@merchant, @discount_1)
    
    within "#edit-discount" do
      expect(page).to have_link("Edit Discount")

      click_link "Edit Discount"
      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant, @discount_1))
    end
  end
end