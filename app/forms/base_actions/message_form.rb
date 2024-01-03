module BaseActions
  class MessageForm < BaseForm
    attribute :content, String

    validates :comment, presence: true
  end
end
