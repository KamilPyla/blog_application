class MessageThread < ApplicationRecord
  belongs_to :adressee, class_name: 'User'
  belongs_to :sender, class_name: 'User'
  has_many :messages

  scope :by_user, ->(user) { where(sender_id: user.id).or(where(adressee_id: user.id)) }

  def blocked?
    adressee.blocked?(sender) || sender.blocked?(adressee)
  end
end
