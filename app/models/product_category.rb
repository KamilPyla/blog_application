class ProductCategory < ApplicationRecord
  has_many :product_sub_categories
end
