module ProfilesHelper
  def following_partial_name(user)
    partial_prefix + (current_user.following?(user) ? 'others_actions/unfollow' : 'others_actions/follow')
  end

  def block_partial_name(user)
    partial_prefix + (current_user.blocked?(user) ? 'others_actions/unblock' : 'others_actions/block')
  end

  def action_partial_name(user)
    partial_prefix + (owner?(user) ? 'owner_actions/actions' : 'others_actions/available_actions')
  end

  def owner?(user)
    current_user.uuid == user.uuid
  end

  def partial_prefix
    'users/profiles/'
  end
end
