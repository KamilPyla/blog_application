class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :event, counter_cache: :total_tickets
end
