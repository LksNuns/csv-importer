class CreateSalesFromCsv
  include Interactor

  def call
    puts ">>>>>>>>"
    puts ">>>>>>>>"
    puts ">>>>>>>>"
    verify_file_exists(csv_file)
    read_csv_file
    puts "verificou"

  end

  def csv_file
    @csv_file ||= context.file
  end

  def read_csv_file
    puts "read csv"
    sale_parser = SaleCsvParser.new(csv_file.path)
    valid_parser = sale_parser.each_sale_params { |params|
      Sale.create(params)
    }
    puts "salvou as paradas"

    unless valid_parser
      context.flash_message = "Arquivo Inválido."
      context.fail!
    end
  end

  def verify_file_exists(file)
    if file.blank?
      puts "Vixxx"
      context.flash_message = "Nenhum arquivo foi selecionado."
      context.fail!
    end
  end
end
