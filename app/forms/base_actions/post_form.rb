module BaseActions
  class PostForm < BaseForm
    attribute :body, ActionText::RichText
    attribute :image, ActiveStorage::Attached::One
    attribute :pictures, ActiveStorage::Attached::Many

    attribute :title, String
    attribute :post_category_id, Integer, default: PostCategory.last.id

    validates :title, presence: true
  end
end
