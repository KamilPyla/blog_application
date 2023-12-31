require 'rails_helper'

RSpec.describe "product_sub_categories/index", type: :view do
  before(:each) do
    assign(:product_sub_categories, [
      ProductSubCategory.create!(
        name: "Name",
        parent_category: nil
      ),
      ProductSubCategory.create!(
        name: "Name",
        parent_category: nil
      )
    ])
  end

  it "renders a list of product_sub_categories" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
