# frozen_string_literal: true

module Authentication
  module UserController
    extend ActiveSupport::Concern

    private

    def check_ability
      return if user_signed_in?

      render :file => "public/401.html", :status => :unauthorized
    end

    def user_log_in?
      return if user_signed_in?

      redirect_to new_user_session_path, alert: 'Aby wykonać akcję musisz się zarejestrować.'
    end
  end
end
