class Stock < ActiveRecord::Base
  attr_accessible :price, :quantity, :symbol
  paginates_per 8

  # ---- validations ---- #
  
  validates :symbol,  :presence => true, :uniqueness => true,
                    :length => {:minimum => 1, :maximum => 5}
  validates_format_of :symbol, :with => /^\w+$/i, :message => "can only contain letters and numbers.(and no spaces allowed)"              
  validates :price, :presence => true, :numericality => { :greater_than => 0 },
                    :length => {:minimum => 1, :maximum => 10}  
  validates :quantity, :presence => true, :numericality => { :only_integer => true,  :greater_than => 0},
                    :length => {:minimum => 1, :maximum => 10}                                      
  validate  :symbol_must_exist 
  
  before_validation :uppercase_symbol

  def uppercase_symbol
    self.symbol.upcase!
  end          
  def symbol_must_exist  # Yahoo returns an 'N/A' in the Ask and Bid fields if bogus stock symbol requested
     if stock_array[1] == 'N/A' 
       errors.add('symbol', 'does not exist') 
     end
  end
   
  def to_label   # Use as Form Label for subform
    "Stock"
  end  

  def self.validate_field(field, value)
    validity = Stock.new(field => value)
    validity.valid?
    if validity.errors.on field
      ajaxResponse = {:valid => false, field.to_sym => validity.errors[field]}
    else
      ajaxResponse = {:valid => true}
    end  
  end
  
  # ---- virtual fields ---- #
  # CSV.parse_line(YahooStock.find_by_symbol(symbol).parsed_response) 
  # returns an Array consisting of Stock Symbol, Ask Price, Bid Price
  

  
  def stockname
    return stock_array[0]
  end
  
  def yahoo_ask_price
    return stock_array[1].to_f
  end
  
  def yahoo_value
     stock_array[1].to_f * quantity
  end
  
  def purchased_value
    price * quantity
  end
  
  def difference
    yahoo_value - purchased_value
  end
  
private

  def stock_array
    @stock_array  ||=  CSV.parse_line(YahooStock.find_by_symbol(symbol).parsed_response)
  end
  
end


