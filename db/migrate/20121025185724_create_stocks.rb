class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.float :price
      t.integer :quantity
      t.timestamps
    end
  end
end
