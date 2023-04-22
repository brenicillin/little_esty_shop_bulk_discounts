require 'rails_helper'

RSpec.describe 'Bulk Discount New Page' do
  before(:each) do
    @merchant = Merchant.create!(name: 'Merchant 1')
    visit new_merchant_bulk_discount_path(@merchant)
  end

  describe 'Form to create a new bulk discount' do
    it 'has a form to create a new bulk discount' do
      expect(page).to have_field(:bulk_discount_name)
      expect(page).to have_field(:bulk_discount_discount)
      expect(page).to have_field(:bulk_discount_threshold)
      expect(page).to have_button("Create Bulk Discount")
    end
  end

  describe 'Create a new bulk discount' do
    it 'creates a new bulk discount' do
      fill_in :bulk_discount_name, with: 'Fire Sale'
      fill_in :bulk_discount_discount, with: 50
      fill_in :bulk_discount_threshold, with: 10
      click_button "Create Bulk Discount"

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
      expect(page).to have_content("Fire Sale")
      expect(page).to have_content("Total Discount: 50%")
      expect(page).to have_content("Items to Earn Discount: 10")
    end
  end

  describe 'edge case: missing information' do
    it 'does not create a new bulk discount if missing information' do
      click_button "Create Bulk Discount"

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant))
      expect(page).to have_content("Discount not created: Required information missing.")
    end
  end
end