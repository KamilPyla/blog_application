module PostsHelper
  def post_author?
    author.uuid == current_user&.uuid
  end

  def author
    @author ||= @object.user
  end
end
