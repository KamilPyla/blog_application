module ApplicationHelper
  def current_role
    if current_user || current_admin
      user_signed_in? ? 'user' : 'admin'
    else
      'empty'
    end
  end

  def comment_author?(comment)
    comment.user_id == current_user.id
  end

  def object_author?(object)
    object.user_id == current_user.id
  end
end
