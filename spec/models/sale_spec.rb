require 'rails_helper'

RSpec.describe Sale do
  describe "shoulda matchers" do
    it { is_expected.to validate_presence_of(:amount_centavos) }
    it { is_expected.to validate_numericality_of(:amount_centavos) }
    it { is_expected.to validate_presence_of(:quantity) }
  end

  describe ".descendent" do
    let!(:first_sale) { FactoryGirl.create(:sale, created_at: 1.day.ago.localtime) }
    let!(:last_sale) { FactoryGirl.create(:sale) }

    it "returns most recents first" do
      expect(Sale.descendent).to eq [last_sale, first_sale]
    end
  end

  describe ".total_amount" do
    it "returns total amount of all sales multiply by quantity" do
      sale1 = FactoryGirl.create(:sale, amount_centavos: 300, quantity: 10)
      sale2 = FactoryGirl.create(:sale, amount_centavos: 250, quantity: 4)
      sale3 = FactoryGirl.create(:sale, amount_centavos: 100, quantity: 5)

      expect(Sale.total_amount).to eq Money.new(4500)
    end
  end

end
