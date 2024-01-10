class Event < ApplicationRecord
  include Reactable

  belongs_to :user, counter_cache: :total_events
  has_many :tickets

  has_one_attached :image
  has_rich_text :content

  before_save :set_proper_start_at

  scope :followers, ->(user) { where(user_id: user.following_users_ids) }
  scope :active, ->() { where('start_at > ?', Time.zone.now) }

  def image_preload
    image.attached? ? image : ''
  end

  def image_as_thumbnail
    return '' unless image.content_type.in?(%w[image/jpeg image/png])

    image.variant(resize_to_limit: [150, 150]).processed
  end

  private

  def set_proper_start_at
    self.start_at = "#{date} #{start_at.strftime('%H:%M')}".to_time
  end
end
