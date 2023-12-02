module Users
  class ProfilesController < CommonActionController
    include ::ActivityLogs::Loggable

    before_action :set_object, only: %i[show edit update block following]
    before_action :validate_password, only: %i[update]
    after_action :create_log, only: %i[update block following]
    before_action :load_action_context, only: %i[update block following]

    def show
      redirect_to root_path, alert: 'Nie znaleziono użytkownika' if @object.blank?
    end

    def edit
      redirect_to root_path, alert: 'Nie znaleziono użytkownika' if @object.blank?
    end

    def update
      respond_to do |format|
        if @action_context.perform
          format.html { redirect_to users_profile_path(@object.uuid), notice: 'Edytowano profil' }
        else
          format.html { redirect_to users_edit_profile_path(@object.uuid), alert: 'Akcja nie udała się' }
        end
      end
    end

    def block
      if self_action
        redirect_to users_profile_path(@object.uuid), status: :unprocessable_entity, alert: 'Nie możesz zablokować samego siebie'
      end

      respond_to do |format|
        if @action_context.perform
          format.html { redirect_to users_profile_path(@object.uuid), notice: 'Zablokowano użytkownika' }
        else
          format.html { redirect_to users_profile_path(@object.uuid), alert: 'Akcja nie udała się' }
        end
      end
    end

    def following
      if self_action
        render users_profile_path(current_user), status: :unprocessable_entity, alert: 'Nie możesz obserwować samego siebie'
      end

      respond_to do |format|
        if @action_context.perform
          format.html { redirect_to profile_path(@object.uuid), notice: 'Dodano do obserwowanych' }
        else
          format.html { redirect_to profile_path(@object.uuid), alert: 'Akcja nie udała się' }
        end
      end
    end

    def preseter
      ::UserPresenter.new(@object)
    end

    private

    def permitted_params
      params.fetch(:user, params).permit!
    end

    def set_object
      @object = User.find_by(uuid: params[:uuid]) || User.find_by(login: params[:login])
    end

    def self_action
      current_user.uuid == @object.uuid
    end

    def action_subject
      :user
    end

    def passowrd
      params.dig(:user, :password)
    end

    def validate_password
      return if current_user.valid_password?(passowrd)

      redirect_to users_edit_profile_path(current_user.uuid), alert: 'Błędne hasło'
    end
  end
end
