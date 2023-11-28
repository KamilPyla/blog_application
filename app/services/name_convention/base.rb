module NameConvention
  class Base
    def initialize(kind, action = '')
      @kind = kind.to_s
      @action = action.to_s
    end

    def name
      raise NotImplementedError, __method__
    end

    private

    attr_reader :kind, :action
  end
end
