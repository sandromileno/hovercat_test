require 'thor'

module Hovercat
  module Cli
    class HovercatCommand < Thor
      map %w(-v --version) => :version
      map %w(-) => :start

      check_unknown_options!

      desc "Redis storage", "Storage all retry data in redis"
      def redis_store
        puts "Hello #{name}"
      end

      desc "Memory storage", "Storage all retry data in local memory"
      def memory_store
        Hovercat::Generators::MemoryConfigGenerator.start
      end

      desc "version", "Shows the Hovercat version"
      def version
        Hovercat::Generators::RedisConfigGenerator.start
      end
    end
  end
end