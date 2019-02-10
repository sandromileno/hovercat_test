require 'hovercat/version'
require 'hovercat/config'

# Dir[File.expand_path('hovercat/*.rb', __dir__)].map { |path| require path }
# Dir[File.expand_path('hovercat/connectors/*.rb', __dir__)].map { |path| require path }
# Dir[File.expand_path('hovercat/exceptions/*.rb', __dir__)].map { |path| require path }
# Dir[File.expand_path('hovercat/gateways/*.rb', __dir__)].map { |path| require path }
# Dir[File.expand_path('hovercat/generators/*.rb', __dir__)].map { |path| require path }
# Dir[File.expand_path('hovercat/jobs/*.rb', __dir__)].map { |path| require path }
# Dir[File.expand_path('hovercat/models/*.rb', __dir__)].map { |path| require path }
# Dir[File.expand_path('hovercat/publishers/*.rb', __dir__)].map { |path| require path }
# Dir[File.expand_path('hovercat/senders/*.rb', __dir__)].map { |path| require path }

module Hovercat
  CONFIG = Hovercat::Config.new.configs
  class Sender
    def self.publish(_params)
    end
  end
end
