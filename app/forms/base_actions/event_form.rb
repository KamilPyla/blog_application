module BaseActions
  class EventForm < BaseForm
    attribute :content, ActionText::RichText
    attribute :image, ActiveStorage::Attached::One

    attribute :title, String
    attribute :street, String
    attribute :city, String

    attribute :price, Integer
    attribute :max_tickets, Integer

    attribute :date, Date
    attribute :start_at, Time

    validates :title, presence: true
  end
end
