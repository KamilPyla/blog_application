class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_rich_text :about_me

  has_many :posts
  has_many :activity_logs
  has_many :events
  has_many :tickets
  has_many :comments

  has_many :own_threads, class_name: 'MessageThread',
                         foreign_key: :sender_id
  has_many :other_threads, class_name: 'MessageThread',
                           foreign_key: :adressee_id

  has_many :active_obserwations, class_name: 'Observation',
                                 foreign_key: :follower_id,
                                 dependent: :destroy
  has_many :following, through: :active_obserwations, source: :followed

  has_many :passive_obserwations, class_name: 'Observation',
                                  foreign_key: :followed_id,
                                  dependent: :destroy

  has_many :followers, through: :passive_obserwations, source: :follower

  has_many :active_blockade, class_name: 'Blockade',
                             foreign_key: :blocker_id,
                             dependent: :destroy

  has_many :blocked_users, through: :active_blockade, source: :blocked

  has_many :passive_blockade, class_name: 'Blockade',
                              foreign_key: :blocked_id,
                              dependent: :destroy

  has_many :blockers, through: :passive_blockade, source: :blocker

  validates :login, uniqueness: true

  def threads
    own_threads + other_threads
  end

  def blocked?(other_user)
    blocked_users.pluck(:id).include?(other_user.id)
  end

  def following?(other_user)
    following_users_ids.include?(other_user.id)
  end

  def following_users_ids
    following.pluck(:id)
  end

  def full_name
    return "#{first_name} #{last_name}" if all_personal_data_filled?

    email
  end

  def all_personal_data_filled?
    first_name.present? && last_name.present? &&
      login.present?
  end

  def avatar_preload
    avatar.attached? ? avatar : ''
  end

  def mini_avatar
    avatar.variant(resize_to_limit: [150, 150]).processed
  end
end
