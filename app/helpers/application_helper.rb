module ApplicationHelper
  def current_role
    if current_user || current_admin
      user_signed_in? ? 'user' : 'admin'
    else
      'empty'
    end
  end


  def object_author?(object)
    return unless current_user

    object.user_id == current_user.id
  end

  def like_button(object)
    if object.liked?(current_user)
      button_to(
        'Podoba Ci się', 
        dislike_activity_path(kind: object.class.to_s, id: object.id),
        class: 'btn btn-primary',
        method: :delete,
        data: { turbo: false }
      )
    else
      button_to(
        'Podoba mi się!',
        like_activity_path(kind: object.class.to_s, id: object.id),
        class: 'btn btn-outline-primary',
        method: :post,
        data: { turbo: false }
      )
    end
  end
end
