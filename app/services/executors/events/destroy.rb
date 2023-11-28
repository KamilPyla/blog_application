module Executors
  module Events
    class Destroy < Executors::Base
      def perform
        event.destroy!
      end

      private

      def event
        object
      end
    end
  end
end
