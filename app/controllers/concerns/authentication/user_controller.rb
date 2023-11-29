# frozen_string_literal: true

module Authentication
  module UserController
    extend ActiveSupport::Concern

    private

    def check_ability
      return if user_signed_in?

      render :file => "public/401.html", :status => :unauthorized
    end
  end
end
