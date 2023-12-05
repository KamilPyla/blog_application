class Observation < ApplicationRecord
  belongs_to :follower, class_name: 'User', counter_cache: :total_followed
  belongs_to :followed, class_name: 'User', counter_cache: :total_followers
end
