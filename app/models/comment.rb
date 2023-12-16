class Comment < ApplicationRecord
  include Commentable
  include Reactable

  belongs_to :user
  belongs_to :subject, polymorphic: true
end
