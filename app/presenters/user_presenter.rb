class UserPresenter
  def initialize(user)
    @user = user
  end

  def avatar_picture
    avatar.attached? ? avatar : default_avatar_path
  end

  def followers
    user.followers.count
  end

  def posts
    user.posts.count
  end

  def events
    user.events.count
  end

  delegate :full_name, :about_me, :total_blocked, :total_events, :uuid,
           :total_followed, :total_followers, :total_posts, to: :user

  attr_reader :user

  private

  delegate :avatar, to: :user

  def default_avatar_path
    'default_avatar.png'
  end

  def resized_avatar
    avatar.variant(resize_to_limit: [300, 300]).processed
  end
end
