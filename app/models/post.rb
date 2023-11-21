class Post < ApplicationRecord
  belongs_to :user
  belongs_to :post_category

  has_one_attached :image
  has_many_attached :pictures
  has_rich_text :body

  def image_as_thumbnail
    return unless image.content_type.in?(%w[image/jpeg image/png])

    image.variant(resize_to_limit: [300, 300]).processed
  end

  def picture_as_thumbnail(picture)
    picture.variant(resize_to_limit: [300, 300]).processed
  end
end
