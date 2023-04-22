require 'rails_helper'

RSpec.describe 'Bulk Discount Index Page' do
  before(:all) do
    @merchant = Merchant.create!(name: 'Merchant 1')
    @discount_1 = BulkDiscount.create!(name: 'Discount 1', merchant_id: @merchant.id, threshold: 10, discount: 10)
    @discount_2 = BulkDiscount.create!(name: 'Discount 2', merchant_id: @merchant.id, threshold: 20, discount: 20)

  end
  describe 'List of links to each bulk discount' do
    it 'has a link to each bulk discount' do
      visit merchant_bulk_discounts_path(@merchant)

      within "#discount-#{@discount_1.id}" do
        expect(page).to have_link(@discount_1.name)
        expect(page).to have_content("Total Discount: #{@discount_1.discount}%")
        expect(page).to have_content("Items to Earn Discount: #{@discount_1.threshold}")
        expect(page).to_not have_link(@discount_2.name)
        expect(page).to_not have_content("Total Discount: #{@discount_2.discount}%")
        expect(page).to_not have_content("Items to Earn Discount: #{@discount_2.threshold}")
      end

      within "#discount-#{@discount_2.id}" do
        expect(page).to have_link(@discount_2.name)
        expect(page).to have_content("Total Discount: #{@discount_2.discount}%")
        expect(page).to have_content("Items to Earn Discount: #{@discount_2.threshold}")
        expect(page).to_not have_link(@discount_1.name)
        expect(page).to_not have_content("Total Discount: #{@discount_1.discount}%")
        expect(page).to_not have_content("Items to Earn Discount: #{@discount_1.threshold}")
      end
    end
  end
end