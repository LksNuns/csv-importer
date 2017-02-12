require 'rails_helper'

feature 'Sales Index' do
  scenario "imports a valid file", js: true do
    sale_page = SaleIndexPage.new
    sale_page.visit_page.import_file
    expect(sale_page).to have_sale("Beltrano sem rumo")
  end
end
