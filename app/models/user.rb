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

  def blocked?(user)
    blocked_users.pluck(:id).include?(user.id)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
