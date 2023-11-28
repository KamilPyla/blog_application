module NameConvention
  module_function

  def identify(name, *options)
    "::NameConvention::#{name.to_s.camelize}".constantize.new(*options).name
  end

  def klass_name(...)
    identify(...).to_s.constantize
  end
end
