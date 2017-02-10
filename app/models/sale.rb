# == Schema Information
#
# Table name: sales
#
#  id          :integer          not null, primary key
#  buyer       :string
#  description :text
#  amount      :integer          not null
#  price       :integer          not null
#  address     :string
#  provider    :string
#

class Sale < ActiveRecord::Base
end
