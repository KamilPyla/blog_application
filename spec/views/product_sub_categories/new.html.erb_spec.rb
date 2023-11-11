require 'rails_helper'

RSpec.describe "product_sub_categories/new", type: :view do
  before(:each) do
    assign(:product_sub_category, ProductSubCategory.new(
      name: "MyString",
      parent_category: nil
    ))
  end

  it "renders new product_sub_category form" do
    render

    assert_select "form[action=?][method=?]", product_sub_categories_path, "post" do

      assert_select "input[name=?]", "product_sub_category[name]"

      assert_select "input[name=?]", "product_sub_category[parent_category_id]"
    end
  end
end
