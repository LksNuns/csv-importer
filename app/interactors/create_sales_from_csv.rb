class CreateSalesFromCsv
  include Interactor

  def call
    verify_file_exists(csv_file)
    read_csv_file
  end

  def read_csv_file
    sale_parser = SaleCsvParser.new(csv_file.path)
    valid_parser = sale_parser.each_sale_params { |params|
      Sale.create(params)
    }

    unless valid_parser
      context.error_message = "Arquivo Inválido."
      context.fail!
    end
  end

  def verify_file_exists(file)
    if file.blank?
      context.error_message = "Nenhum arquivo foi selecionado."
      context.fail!
    end
  end

  private

  def csv_file
    @csv_file ||= context.file
  end
end
