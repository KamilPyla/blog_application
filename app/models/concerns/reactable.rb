module Reactable
  extend ActiveSupport::Concern

  included do
    has_many :reactions, as: :subject, dependent: :destroy
  end

  def liked?(user)
    return unless user

    reactions.pluck(:user_id).include?(user.id)
  end
end
