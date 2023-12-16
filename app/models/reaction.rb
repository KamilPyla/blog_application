class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :subject, polymorphic: true, counter_cache: :total_reactions
end
