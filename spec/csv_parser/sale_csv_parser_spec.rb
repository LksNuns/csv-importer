require 'rails_helper'

RSpec.describe SaleCsvParser do
  let(:parser) { SaleCsvParser.new("spec/support/files/sale_data.csv") }
  let(:file_csv) { parser.open_csv }

  describe "#open_csv" do
    context "when file exists" do
      it "open a file" do
        expect(file_csv.class).to be CSV::Table
      end
    end
  end

  describe ".sale_params" do
    context "expect rows with" do
      subject!(:sale_params) { SaleCsvParser.sale_params(file_csv.first) }

      it "buyer column" do
        expect(sale_params[:buyer]).to eq "Fulano de Tal"
      end
      it "description column" do
        expect(sale_params[:description]).to eq "R$2.99 balinhas"
      end
      it "amount_centavos column" do
        expect(sale_params[:amount]).to eq Money.new(299)
      end
      it "quantity column" do
        expect(sale_params[:quantity]).to eq 5
      end
      it "address column" do
        expect(sale_params[:address]).to eq "Rua de Casa"
      end
      it "provider column" do
        expect(sale_params[:provider]).to eq "Venda da Esquina"
      end
    end
  end

  describe "#valid?" do
    it "returns true when have no errors" do
      parser.error = nil

      expect(parser.valid?).to be true
    end

    it "returns false when have errors" do
      parser.error = "Arquivo inválido"

      expect(parser.valid?).to be false
    end
  end

  describe "#verify_file" do
    context "when has an error" do
      it "invalid file" do
        parser = SaleCsvParser.new("spec/support/files/not_exists.bla")

        expect(parser.error).to eq "Arquivo não encontrado."
      end

      it "blank file" do
        parser = SaleCsvParser.new("")

        expect(parser.error).to eq "Nenhum arquivo foi selecionado."
      end

      it "invalid content type" do
        parser = SaleCsvParser.new("spec/support/files/photo.jpg")

        expect(parser.error).to eq "Formato inválido de arquivo."
      end

      it "miss columns" do
        parser = SaleCsvParser.new("spec/support/files/sale_data_invalid_columns.csv")

        expect(parser.error).to eq "As seguintes colunas não foram encontradas: preco_unitario e endereco"
      end
    end

    context "when is a valid file" do
      it "has no errors" do
        parser = SaleCsvParser.new("spec/support/files/sale_data.csv")

        expect(parser.error).to eq nil        
      end
    end
  end
end
