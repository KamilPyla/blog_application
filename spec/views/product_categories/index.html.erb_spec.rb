require 'rails_helper'

RSpec.describe "product_categories/index", type: :view do
  before(:each) do
    assign(:product_categories, [
      ProductCategory.create!(
        name: "Name"
      ),
      ProductCategory.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of product_categories" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
  end
end
