class SalesController < ApplicationController

  def index
    @sales = Sale.descendent
  end

  def import_csv
    sale_parser = SaleCsvParser.new(params[:file].path)

    sale_parser.each_row_params do |row|
      Sale.create(row)
    end

    redirect_to sales_path
  end

end
