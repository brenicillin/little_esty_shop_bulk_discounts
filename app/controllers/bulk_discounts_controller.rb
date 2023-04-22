class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.bulk_discounts
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.bulk_discounts.new(discount_params)
    if @discount.save
      redirect_to merchant_bulk_discounts_path(@discount.merchant_id)
    else 
      redirect_to new_merchant_bulk_discount_path(params[:bulk_discount][:merchant_id])
      flash[:alert] = "Discount not created: Required information missing."
    end
  end

  def destroy
    @discount = BulkDiscount.find(params[:id])
    @discount.destroy
    redirect_to merchant_bulk_discounts_path(@discount.merchant_id)
  end

  private

  def discount_params
    params.require(:bulk_discount).permit(:name, :discount, :threshold, :merchant_id)
  end
end