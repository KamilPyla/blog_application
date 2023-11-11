require 'rails_helper'

RSpec.describe "product_sub_categories/edit", type: :view do
  let(:product_sub_category) {
    ProductSubCategory.create!(
      name: "MyString",
      parent_category: nil
    )
  }

  before(:each) do
    assign(:product_sub_category, product_sub_category)
  end

  it "renders the edit product_sub_category form" do
    render

    assert_select "form[action=?][method=?]", product_sub_category_path(product_sub_category), "post" do

      assert_select "input[name=?]", "product_sub_category[name]"

      assert_select "input[name=?]", "product_sub_category[parent_category_id]"
    end
  end
end
