module Executors
  module Events
    class BuyTicket < Executors::Base
      def perform
        ticket.save!
      end

      private

      def ticket
        event.tickets.new(user: user)
      end

      def event
        @event ||= object
      end
    end
  end
end
