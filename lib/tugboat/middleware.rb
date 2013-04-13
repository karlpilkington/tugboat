require "middleware"

module Tugboat
  module Middleware
    autoload :Base, "tugboat/middleware/base"
    autoload :InjectConfiguration, "tugboat/middleware/inject_configuration"
    autoload :CheckConfiguration, "tugboat/middleware/check_configuration"
    autoload :AskForCredentials, "tugboat/middleware/ask_for_credentials"
    autoload :InjectClient, "tugboat/middleware/inject_client"
    autoload :CheckCredentials, "tugboat/middleware/check_credentials"
    autoload :ListDroplets, "tugboat/middleware/list_droplets"


    # This takes the user through the authorization flow
    def self.sequence_authorize
      ::Middleware::Builder.new do
        use InjectConfiguration
        use AskForCredentials
        use CheckConfiguration
        use InjectClient
        use CheckCredentials
      end
    end

    # This provides a list of droplets
    def self.sequence_list_droplets
      ::Middleware::Builder.new do
        use InjectConfiguration
        use CheckConfiguration
        use InjectClient
        use ListDroplets
      end
    end
  end
end
