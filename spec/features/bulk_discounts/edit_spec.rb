require 'rails_helper'

RSpec.describe 'Bulk Discount Edit Page' do
  before(:each) do
    @merchant = Merchant.create!(name: 'Merchant 1')
    @discount_1 = BulkDiscount.create!(name: 'Discount 1', merchant_id: @merchant.id, threshold: 10, discount: 20)
  end

  describe 'Bulk discount edit form' do
    it 'has a form to edit the discount' do
      visit edit_merchant_bulk_discount_path(@merchant, @discount_1)

      within "#edit-discount" do
        expect(page).to have_field("Name", with: @discount_1.name)
        expect(page).to have_field("Discount", with: @discount_1.discount)
        expect(page).to have_field("Threshold", with: @discount_1.threshold)
      end
    end

    it 'can edit the discount' do
      visit edit_merchant_bulk_discount_path(@merchant, @discount_1)

      within "#edit-discount" do
        fill_in "Name", with: "Discount 5"
        fill_in "Discount", with: 50
        fill_in "Threshold", with: 15
        click_button "Update Bulk Discount"
      end

      expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @discount_1))
      expect(page).to have_content("Discount 5")
      expect(page).to have_content(50)
      expect(page).to have_content(15)
      expect(page).to_not have_content(@discount_1.name)
      expect(page).to_not have_content(@discount_1.discount)
      expect(page).to_not have_content(@discount_1.threshold)
    end
  end
end