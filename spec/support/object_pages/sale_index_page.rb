class SaleIndexPage
  include Capybara::DSL

  def visit_page
    visit('/sales')
    self
  end

  def import_file(path = 'spec/support/files/sale_data.csv')
    within("#import_sale_csv") do
      page.execute_script("$('#sale_csv_input').show();");
      attach_file('sale_csv_input', File.absolute_path(path))
    end
    page.find("#submit_sale_file").click
    self
  end

  def has_sale?(buyer)
    find('#sales_table').has_css? 'td', text: buyer
  end

  def has_error?(message)
    find('#error-msg').text == message
  end
end
