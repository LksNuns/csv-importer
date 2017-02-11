class SalesController < ApplicationController

  def index
    @sales = Sale.descendent
  end

  def import_csv
    sale_parser = SaleCsvParser.new(params[:file].path)
    sale_parser.each_sale_params! { |params| Sale.create(params) }
    redirect_to sales_path
  end

  private

  def sale_params
    params.permit(:file)
  end

end
