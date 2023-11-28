module NameConvention
  class ActionForm < Base
    def name
      "::BaseActions::#{kind.camelize}Form"
    end
  end
end
