# frozen_string_literal: true

module Authentication
  module AdminController
    extend ActiveSupport::Concern

    private

    def check_ability
      return if admin_signed_in?

      render json: 404, status: :not_found
    end
  end
end
