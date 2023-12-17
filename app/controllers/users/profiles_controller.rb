module Users
  class ProfilesController < CommonActionController
    include ::ActivityLogs::Loggable

    before_action :set_object, only: %i[show edit update block follow unblock unfollow show_following show_followers]
    before_action :validate_password, only: %i[update]
    after_action :create_log, only: %i[update block follow unblock unfollow]
    before_action :load_action_context, only: %i[update block follow unfollow unblock]
    before_action :self_action, only: %i[follow block unfollow unblock]
    after_action :broadcast_stats_changes, only: %i[follow block unfollow unblock]
    after_action :broadcast_changes, only: %i[follow block unfollow unblock]

    def show
      redirect_to root_path, alert: 'Nie znaleziono użytkownika' if @object.blank?
      user_presenter
    end

    def show_followers
      @followers = @object.followers.includes(avatar_attachment: :blob)
    end

    def show_following
      @following = @object.following.includes(avatar_attachment: :blob)
    end

    def show_blocked
      @blocked = current_user.blocked_users.includes(avatar_attachment: :blob)
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
      respond_to do |format|
        if @action_context.perform
          format.html { redirect_to users_profile_path(@object.uuid), notice: 'Zablokowano użytkownika' }
          format.turbo_stream {}
        else
          format.html { redirect_to users_profile_path(@object.uuid), alert: 'Akcja nie udała się' }
        end
      end
    end

    def unblock
      respond_to do |format|
        if @action_context.perform
          format.html { redirect_to users_profile_path(@object.uuid), notice: 'Odblokowano użytkownika' }
          format.turbo_stream {}
        else
          format.html { redirect_to users_profile_path(@object.uuid), alert: 'Akcja nie udała się' }
        end
      end
    end

    def follow
      respond_to do |format|
        if @action_context.perform
          format.html { redirect_to users_profile_path(@object.uuid), notice: 'Dodano do obserwowanych' }
          format.turbo_stream {}
        else
          format.html { redirect_to users_profile_path(@object.uuid), alert: 'Akcja nie udała się' }
        end
      end
    end

    def unfollow
      respond_to do |format|
        if @action_context.perform
          format.html { redirect_to users_profile_path(@object.uuid), notice: 'Usunięto z obserwowanych' }
          format.turbo_stream {}
        else
          format.html { redirect_to users_profile_path(@object.uuid), alert: 'Akcja nie udała się' }
        end
      end
    end

    def user_presenter
      @user_presenter ||= ::UserPresenter.new(@object)
    end

    private

    def broadcast_changes
      Turbo::StreamsChannel.broadcast_replace_to :"dynamic_users_list_#{current_user.uuid}",
                                                 target: "user_#{@object.uuid}",
                                                 partial: 'users/profiles/user_row',
                                                 locals: { user: @object, current_user: current_user }
    end

    def broadcast_stats_changes
      Turbo::StreamsChannel.broadcast_replace_to :"dynamic_stats_#{current_user.uuid}",
                                                 target: "user_stats_#{current_user.uuid}",
                                                 partial: 'users/profiles/stats_table',
                                                 locals: { presenter: current_user_presenter, current_user: current_user }
    end

    def current_user_presenter
      ::UserPresenter.new(current_user.reload)
    end

    def permitted_params
      params.fetch(:user, params).permit!
    end

    def set_object
      @object = User.find_by(uuid: params[:uuid]) || User.find_by(login: params[:login])
    end

    def self_action
      return unless current_user.uuid == @object.uuid

      redirect_to users_profile_path(@object.uuid), alert: 'Nie możesz wykonać tej akcji'
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
