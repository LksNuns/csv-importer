require 'csv'

class SaleCsvParser
  def initialize(file)
    @file = file
  end

  def each_sale_params!
    open_csv.each do |row|
      params = self.class.sale_params(row)
      yield params
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
end
