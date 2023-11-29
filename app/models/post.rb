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

[
  'Technologia i Gadżety',
  'Podróże',
  'Sztuka i Kultura',
  'Zdrowie i Fitness',
  'Kulinaria i Gotowanie',
  'Motywacja i Rozwój Osobisty',
  'Recenzje Książek i Filmów',
  'Moda i Styl Życia',
  'Sporty Ekstremalne',
  'Edukacja i Nauka',
  'Fotografia',
  'Biznes i Kariera',
  'Rodzina i Parenting',
  'Design i Architektura',
  'Środowisko i Ekologia',
  'Hobby i Rękodzieło',
  'Finanse i Inwestowanie',
  'Porady Techniczne',
  'Historia i Tradycje',
  'Humor i Rozrywka'
  ]