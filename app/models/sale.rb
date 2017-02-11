# == Schema Information
#
# Table name: sales
#
#  id              :integer          not null, primary key
#  buyer           :string
#  description     :text
#  qunatity        :integer          not null
#  amount_centavos :integer          default(0), not null
#  amount_currency :string           default("BRL"), not null
#  address         :string
#  provider        :string
#  created_at      :datetime
#  updated_at      :datetime
#

class Sale < ActiveRecord::Base
  validates :amount_centavos, :quantity, presence: true
  validates :amount_centavos, :quantity, numericality: { greater_than_or_equal_to: 0 }

  scope :descendent, -> { order(created_at: :desc) }

  monetize :amount_centavos
end
