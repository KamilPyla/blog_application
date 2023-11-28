module NameConvention
  class ActivityLogsMessage < Base
    def name
      "ActivityLogs::Message::#{kind.camelize}"
    end
  end
end
