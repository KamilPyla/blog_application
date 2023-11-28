class ActionContext
  def initialize(user:, kind:, action:, params: {}, object: nil)
    @user = user
    @kind = kind
    @action = action
    @object = object
    @params = params.compact
  end

  def perform
    ActiveRecord::Base.transaction do
      executor_class.perform(
        user:,
        object:,
        form_attributes:
      )
    end
  end

  def form
    form_klass.new(params)
  end

  private

  attr_reader :user, :kind, :action, :params, :object

  def form_attributes
    form.attributes
  end

  def executor_class
    NameConvention.klass_name(:base_executor, kind, action)
  end

  def form_klass
    NameConvention.klass_name(:action_form, kind)
  end
end
