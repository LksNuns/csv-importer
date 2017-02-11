require 'rails_helper'

RSpec.describe SaleCsvParser do
  let(:sale_parser) { SaleCsvParser.new("spec/support/files/sale_data.csv").open_csv }

  describe "#open_csv" do
    context "when file exists" do
      it "open a file" do
        expect(sale_parser.class).to be CSV::Table
      end
    end
  end

  describe ".sale_params" do
    context "expect rows with" do
      before do
        @sale_params = SaleCsvParser.sale_params(sale_parser.first)
      end

      it "buyer column" do
        expect(@sale_params[:buyer]).to eq "Fulano de Tal"
      end
      it "description column" do
        expect(@sale_params[:description]).to eq "R$2.99 balinhas"
      end
      it "amount_centavos column" do
        expect(@sale_params[:amount]).to eq Money.new(299)
      end
      it "quantity column" do
        expect(@sale_params[:quantity]).to eq 5
      end
      it "address column" do
        expect(@sale_params[:address]).to eq "Rua de Casa"
      end
      it "provider column" do
        expect(@sale_params[:provider]).to eq "Venda da Esquina"
      end
    end
  end
end
