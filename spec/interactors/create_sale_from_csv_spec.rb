require 'rails_helper'

describe CreateSalesFromCsv do

  describe ".call" do
    context "when given valid file" do

      it "succeeds" do
        file = double("file")
        allow(file).to receive(:path).and_return('spec/support/files/sale_data.csv')

        context = CreateSalesFromCsv.call(file: file)

        expect(context).to be_a_success
      end
    end

    context "when given invalid credentials" do
      subject(:context) { CreateSalesFromCsv.call(file: '') }

      it "fails" do
        expect(context).to be_a_failure
      end

      it "provides a failure message" do
        expect(context.error_message).to be_present
      end
    end
  end

  describe "#verify_file_exists" do
    context "when passing with success" do
      it "success" do
        file = double("file")
        allow(file).to receive(:path).and_return('spec/support/files/sale_data.csv')

        context = CreateSalesFromCsv.call(file: file)

        expect(context).to be_a_success
      end
    end

    context "when passing with failure" do
      it "fail" do
        context = CreateSalesFromCsv.call(file: '')

        expect(context).to be_a_failure
      end
    end
  end
end
