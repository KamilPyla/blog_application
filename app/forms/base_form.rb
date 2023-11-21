class BaseForm
  include ::Virtus.model

  extend ::ActiveModel::Naming
  include ::ActiveModel::Conversion
  include ::ActiveModel::Validations
  include ::ActiveModel::Validations::Callbacks
end
