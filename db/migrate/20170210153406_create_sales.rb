class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :buyer
      t.text :description
      t.integer :quantity, null: false
      t.monetize :amount, null: false
      t.string :address
      t.string :provider

      t.timestamps
    end
  end
end
