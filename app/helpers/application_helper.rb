module ApplicationHelper
  def current_role
    if current_user || current_admin
      user_signed_in? ? 'user' : 'admin'
    else
      'empty'
    end
  end
end
