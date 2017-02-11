require 'csv'

class SaleCsvParser
  def initialize(file)
    @file = file
  end

  def each_row_params
    open_csv.each do |row|
      params = self.row_params(row)
      yield params
    end
  end

  def row_params(row)
    price = Sale.to_money(row['preco_unitario']) if row['preco_unitario'].present?
    {
      buyer: row['comprador'],
      description: row['descricao'],
      amount: row['quantidade'],
      price: price,
      address: row['endereco'],
      provider: row['fornecedor']
    }
  end

  private

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
end
