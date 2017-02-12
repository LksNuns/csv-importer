class SalesController < ApplicationController

  def index
    @sales = Sale.descendent.page params[:page]
    @total_sale_amount = Sale.total_amount
  end

  def import_csv
    result = CreateSalesFromCsv.call(file: params[:file])

    flash[:error] = result.error_message if result.failure?
    redirect_to sales_path
  end
end
