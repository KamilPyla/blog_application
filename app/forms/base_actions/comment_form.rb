module BaseActions
  class CommentForm < BaseForm
    attribute :content, String

    validates :comment, presence: true
  end
end
