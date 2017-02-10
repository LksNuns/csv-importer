class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :buyer
      t.text :description
      t.integer :amount, null: false
      t.integer :price, null: false
      t.string :address
      t.string :provider

      t.timestamps
    end
  end
end
