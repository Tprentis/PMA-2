class StocksController < ApplicationController
  before_filter :authorize

  # GET /stocks
  # GET /stocks.json
  def index
    
    @stocks = Stock.order(:symbol).page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stocks }
      format.js
    end
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
    @stock = Stock.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stock }
    end
  end

  # GET /stocks/new
  # GET /stocks/new.json
  def new
    @stock = Stock.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stock }
      format.js
    end
  end

  # GET /stocks/1/edit
  def edit
    @stock = Stock.find(params[:id])
  end

  # POST /stocks
  # POST /stocks.json
  def create
    @stock = Stock.new(params[:stock])
    
   # @stock.symbol = params[:stock][:symbol].to_s.strip.upcase!
  
    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: 'Good Job! And, good luck with this new stock.' }
        format.json { render json: @stock, status: :created, location: @stock }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /stocks/1
  # PUT /stocks/1.json
  def update
    @stock = Stock.find(params[:id])
     
    respond_to do |format|
      if @stock.update_attributes(params[:stock])
        format.html { redirect_to @stock, notice: 'Here\'s your updated stock.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    @stock = Stock.find(params[:id])
    @stock.destroy

    respond_to do |format|
      format.html { redirect_to stocks_url }
      format.json { head :no_content }
      format.js
    end
  end
end 

