module NameConvention
  class BaseExecutor < Base
    def name
      "::Executors::#{kind.pluralize.camelize}::#{action.camelize}"
    end
  end
end
