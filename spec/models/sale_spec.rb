require 'rails_helper'

RSpec.describe Sale do
  describe 'shoulda matchers' do
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:price) }
  end
end
