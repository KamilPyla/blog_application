module PolymorphicLoader
  extend ActiveSupport::Concern

  private

  def nested_subject(object)
    return object unless object.is_a?(Comment)
    
    nested_subject(object.subject)
  end

  def load_object
    return if klass == :empty

    @object ||= klass.find_by(id: params[:id])
  end

  def klass
    params[:kind].classify.constantize

  rescue NameError
    :empty
  end
end
