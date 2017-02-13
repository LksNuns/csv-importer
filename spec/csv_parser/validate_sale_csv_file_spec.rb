require 'rails_helper'

RSpec.describe ValidateSaleCsvFile do
  include ValidateSaleCsvFile
  describe "#verify_structure" do
    context "when passing a valid structure" do
      it "raises no errors" do
        file = SaleCsvParser.new("spec/support/files/sale_data.csv").open_csv

        expect{verify_structure(file)}.to_not raise_error
      end
    end

    context "when passing an invalid structure" do
      it "raises error" do
        file = SaleCsvParser.new("spec/support/files/sale_data_invalid_columns.csv").open_csv

        expect{verify_structure(file)}.to raise_error(
          "As seguintes colunas não foram encontradas: preco_unitario e endereco"
        )
      end
    end
  end
  describe "#verify_content_type" do
    context "when passing a file with a correct content type" do
      it "raises no errors" do
        expect{verify_content_type('spec/support/files/sale_data.csv')}.to_not raise_error
      end
    end

    context "when passing a file with an invalid content type" do
      it "raises errors" do
        expect{verify_content_type('spec/support/files/photo.jpg')}.to raise_error(
          "Formato inválido de arquivo."
        )
      end
    end
  end

  describe "#verify_file_exist" do
    context "when passing a file with a correct path" do
      it "raises no error" do
        expect{verify_file_exist('spec/support/files/sale_data.csv')}.to_not raise_error
      end
    end

    context "when passing a file with an invalid content type" do
      it "raise error to blank path" do
        expect{verify_file_exist('')}.to raise_error(
          "Nenhum arquivo foi selecionado."
        )
      end

      it "raise errror to invalid path" do
        expect{verify_file_exist('spec/support/files/not_exist.bla')}.to raise_error(
          "Arquivo não encontrado."
        )
      end
    end
  end
end
