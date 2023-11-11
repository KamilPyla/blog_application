require 'rails_helper'

RSpec.describe "post_categories/edit", type: :view do
  let(:post_category) {
    PostCategory.create!(
      name: "MyString"
    )
  }

  before(:each) do
    assign(:post_category, post_category)
  end

  it "renders the edit post_category form" do
    render

    assert_select "form[action=?][method=?]", post_category_path(post_category), "post" do

      assert_select "input[name=?]", "post_category[name]"
    end
  end
end
