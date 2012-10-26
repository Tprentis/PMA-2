# Model used to extract stock information from http://finance.yahoo.com/d/quotes.csv
# variable: 'symbol' is passed into the method to find info by the stock symbol
# returns HASH which will be parsed in the "Stock" Model

class YahooStock 
  include HTTParty
  
  def self.find_by_symbol(symbol)
    @symbol = symbol
    @query = 'http://finance.yahoo.com/d/quotes.csv?s=' + @symbol.to_s + '&f=nab' 
    get(@query) 
  end

end
