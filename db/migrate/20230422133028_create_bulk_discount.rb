class CreateBulkDiscount < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.references :merchant, foreign_key: true
      t.string :name
      t.integer :threshold
      t.integer :discount
    end
  end
end
