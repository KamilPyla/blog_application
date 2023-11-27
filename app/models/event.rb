class Event < ApplicationRecord
  belongs_to :user
  has_many :tickets

  has_one_attached :image
  has_rich_text :content

  before_save :set_proper_start_at

  def image_preload
    image.attached? ? image : ''
  end

  private

  def set_proper_start_at
    self.start_at = "#{date} #{start_at.strftime('%H:%M')}".to_time
  end
end
