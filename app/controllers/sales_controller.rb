class SalesController < ApplicationController

  def index
    @sales = Sale.descendent.page params[:page]
    @total_sale_amount = Sale.total_amount
  end

  def import_csv
    result = CreateSalesFromCsv.call(file: params[:file].path)

    if result.success?
      flash[:success] = result.success_message 
    else
      flash[:error] = result.error_message
    end

    redirect_to sales_path
  end
end
