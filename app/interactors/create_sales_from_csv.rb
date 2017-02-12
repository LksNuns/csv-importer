class CreateSalesFromCsv
  include Interactor

  def call
    read_csv_file
  end

  def read_csv_file
    sale_parser = SaleCsvParser.new(csv_file)
    valid_parser = sale_parser.each_sale_params { |params|
      Sale.create(params)
    }

    unless valid_parser
      context.error_message = sale_parser.error
      context.fail!
    end
  end
  private

  def csv_file
    @csv_file ||= context.file
  end
end
