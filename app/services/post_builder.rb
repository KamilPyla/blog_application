class PostBuilder
  def initialize(user, post_attributes)
    @user = user
    @post_attributes = post_attributes
  end

  def perform
    user.posts.build(post_attributes)
  end

  private

  attr_reader :user, :post_attributes
end
