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

end
