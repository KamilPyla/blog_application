module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :subject, dependent: :destroy
  end
end
