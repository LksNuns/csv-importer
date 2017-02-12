require 'csv'

class SaleCsvParser
  include ValidateSaleCsvFile
  
  attr_accessor :error

  def initialize(file)
    @file = file
    verify_file
  end

  def each_sale_params
    if valid?
      open_csv.each do |row|
        params = self.class.sale_params(row)
        yield params
      end
      true
    else
      false
    end
  end

  def self.sale_params(row)
    amount = row['preco_unitario']
    amount = Money.from_amount(amount) if amount.present?
    {
      buyer: row['comprador'],
      description: row['descricao'],
      quantity: row['quantidade'],
      amount: amount,
      address: row['endereco'],
      provider: row['fornecedor']
    }
  end

  def open_csv
    options = {
      headers: true,
      converters: :numeric,
      col_sep: "\t",
      header_converters: lambda { |h|
        I18n.transliterate(h).strip.downcase.gsub(' ', '_') unless h.nil?
      }
    }
    CSV.read(@file, options)
  end

  def valid?
    @error.present? ? false : true
  end

  private

  def verify_file
    @error = verify_file_exist(@file)
    return if error.present?

    @error = verify_content_type(@file)
    return if error.present?

    @error = verify_structure(open_csv)
  end
end
