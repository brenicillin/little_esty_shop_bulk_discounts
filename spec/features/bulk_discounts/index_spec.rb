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

  describe 'Link to create a new bulk discount' do
    it 'has a link to create a new bulk discount' do
      visit merchant_bulk_discounts_path(@merchant)

      within "#new-discount" do
        expect(page).to have_link("Create New Discount")

        click_link "Create New Discount"

        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant))
      end
    end
  end

  describe 'Link to delete a bulk discount' do
    it 'has a link to delete a bulk discount' do
      visit merchant_bulk_discounts_path(@merchant)

      expect(page).to have_content("Discount 1")
      expect(page).to have_content("Total Discount: 10%")
      expect(page).to have_content("Items to Earn Discount: 10")

      within "#discount-#{@discount_1.id}" do
        expect(page).to have_button("Delete Discount 1")

        click_button "Delete Discount 1"
      end

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
      expect(page).to_not have_content("Discount 1")
      expect(page).to_not have_content("Total Discount: 10%")
      expect(page).to_not have_content("Items to Earn Discount: 10")
    end
  end

  describe 'Next 3 upcoming holidays' do
    it 'has the next 3 holidays name and dates' do
      visit merchant_bulk_discounts_path(@merchant)

      within "#holidays" do
        expect(page).to have_content("Upcoming Holidays")
        expect(page).to have_content("Memorial Day - 2023-05-29")
        expect(page).to have_content("Juneteenth - 2023-06-19")
        expect(page).to have_content("Independence Day - 2023-07-04")
      end
    end
  end
end