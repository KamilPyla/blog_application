class Blockade < ApplicationRecord
  belongs_to :blocker, class_name: 'User', counter_cache: :total_blocked
  belongs_to :blocked, class_name: 'User'
end
