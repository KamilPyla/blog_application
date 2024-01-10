class ActivityLog < ApplicationRecord
  belongs_to :user

  enum action_subject: {
    login: 'login',
    post: 'post',
    event: 'event',
    user: 'user',
    comment: 'comment',
    reaction: 'reaction',
    message: 'message'
  }
end
