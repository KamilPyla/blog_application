module Executors
  class Base
    extend ::Performable

    def initialize(user:, form_attributes:, object: nil)
      @user = user
      @form_attributes = form_attributes
      @object = object
    end

    def perform
      raise NotImplementedError, __method__
    end

    private

    attr_reader :user, :form_attributes, :object
  end
end
