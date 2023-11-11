require 'rails_helper'

RSpec.describe "post_categories/index", type: :view do
  before(:each) do
    assign(:post_categories, [
      PostCategory.create!(
        name: "Name"
      ),
      PostCategory.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of post_categories" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
  end
end
