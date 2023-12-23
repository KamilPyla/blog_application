class CommonActionController < ApplicationController
  include ::Authentication::UserController
  include ::Toasts::Broadcaster

  private

  def load_action_context
    @action_context ||= ::ActionContext.new(
      user: current_user,
      kind: action_subject,
      action: action_name,
      params: permitted_params,
      object: @object
    )
  end

  def form
    @action_context.form
  end

  def verify_params
    return if form.valid?

    respond_to do |format|
      format.html do
        flash[:alert] = form.error_message
        render redirector.fetch(action_name)
      end
    end
  end

  def redirector
    {
      'update' => :edit,
      'create' => :new
    }
  end
end
