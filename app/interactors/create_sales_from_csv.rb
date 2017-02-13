class CreateSalesFromCsv
  include Interactor

  def call
    read_csv_file
  end

  def read_csv_file
    sale_parser = SaleCsvParser.new(csv_file)
    parser_success = sale_parser.each_sale_params do |params|
      Sale.create(params)
    end

    if parser_success
      context.success_message = "Dados importados com sucesso."
    else
      context.error_message = sale_parser.error
      context.fail!
    end
  end
  private

  def csv_file
    if @csv_file.blank?
      @csv_file = context.file.blank? ? "" : context.file.path
    end
    @csv_file
  end
end
