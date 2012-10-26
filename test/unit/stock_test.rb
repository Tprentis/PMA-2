require 'test_helper'

class StockTest < ActiveSupport::TestCase

  test "should not create an invalid stock entry" do
    stock = Stock.new
    assert !stock.valid?
    assert stock.errors[:symbol].any?
    assert stock.errors[:price].any?
    assert stock.errors[:quantity].any?
    assert_equal ["can't be blank", "is too short (minimum is 1 characters)"], stock.errors[:symbol]
    assert_equal ["can't be blank", "is not a number", "is too short (minimum is 1 characters)"], stock.errors[:price]
    assert_equal ["can't be blank", "is not a number", "is too short (minimum is 1 characters)"], stock.errors[:quantity]
    assert !stock.save
  end 

  test "should create stock" do
    stock = Stock.new
    stock.symbol = 'SWHC'
    stock.price = 10.00
    stock.quantity = 10
    
    assert stock.save
  end
  
  test "should find stock" do
    stock_id = stocks(:one).id
    assert_nothing_raised{ Stock.find(stock_id) }
  end
  
  test "should update stock" do
    stock = stocks(:two)
    assert stock.update_attributes(:price => 15.55, :quantity => 20)
  end
  
  test "should destroy stock" do
    stock = stocks(:one)
    stock.destroy
    assert_raise(ActiveRecord::RecordNotFound) { Stock.find(stock.id) }
  end
  

end
