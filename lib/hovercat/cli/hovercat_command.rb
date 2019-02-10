require 'thor'

module Hovercat
  module Cli
    class HovercatCommand < Thor
      map %w(-v --version) => :version
      map %w(-) => :start

      check_unknown_options!

      desc "hello NAME", "say hello to NAME"
      def hello(name)
        puts "Hello #{name}"
      end

      desc "version", "Shows the Hovercat version"
      def version
        say "Hovercat v#{SmppClient::VERSION}"
      end
    end
  end
end