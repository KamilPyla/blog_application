class PostForm < BaseForm
  attribute :title, String
  attribute :post_category_id, Integer, default: PostCategory.last.id
end