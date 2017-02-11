class SalesController < ApplicationController

  def index
    @sales = Sale.descendent
    @total_sale_amount = Sale.total_amount
  end

  def import_csv
    sale_parser = SaleCsvParser.new(params[:file].path)
    valid_parser = sale_parser.each_sale_params { |params| Sale.create(params) }

    flash[:error] = "Arquivo inválido." unless valid_parser
    redirect_to sales_path
  end

  private

  def sale_params
    params.permit(:file)
  end

end
