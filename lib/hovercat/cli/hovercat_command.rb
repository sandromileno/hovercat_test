require 'thor'
require 'hovercat/generators/memory_config_generator'
require 'hovercat/generators/redis_config_generator'

module Hovercat
  module Cli
    class HovercatCommand < Thor
      map %w(-v --version) => :version
      map %w(-) => :start

      check_unknown_options!

      desc "Redis storage", "Stores all retry data in redis"
      def redis_store
        Hovercat::Generators::RedisConfigGenerator.start
      end

      desc "Memory storage", "Stores all retry data in local memory"
      def memory_store
        Hovercat::Generators::MemoryConfigGenerator.start
      end

      desc "version", "Shows the Hovercat version"
      def version
        say "Hovercat v#{Hovercat::VERSION}"
      end
    end
  end
end