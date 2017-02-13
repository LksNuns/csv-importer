require 'rails_helper'

describe SalesController do
  describe "#import_csv" do
    before do
      expect(CreateSalesFromCsv).to receive(:call).once.with(file: "file").and_return(context)
    end

    context "when successful" do
      let(:context) { double(:context, success?: true, success_message: "Sucesso") }

      it "set a flash message" do
        expect {
          post :import_csv, file: "file"
        }.to change {
          flash[:success]
        }.from(nil).to("Sucesso")
      end
    end

    context "when unsuccessful" do
      let(:context) { double(:context, success?: false, error_message: "error") }

      it "sets a flash message" do
        expect {
          post :import_csv, file: "file"
        }.to change {
          flash[:error]
        }.from(nil).to("error")
      end

      it "redirects to the homepage" do
        response = post :import_csv, file: "file"

        expect(response).to redirect_to(sales_path)
      end
    end
  end
end
