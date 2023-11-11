require 'rails_helper'

RSpec.describe "product_sub_categories/show", type: :view do
  before(:each) do
    assign(:product_sub_category, ProductSubCategory.create!(
      name: "Name",
      parent_category: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
