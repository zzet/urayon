module Urayon
  class Initializer
    class << self
      def init(*args)
        $config = Urayon::Config.new(args)
        sidekiq($config.resque_uri, $config.resque_namespece)
        $daemon = Urayon::Daemon.new($config)
      end

      def sidekiq(uri, namespace)
        Sidekiq.configure_server do |config|
          config.redis = {
            url: uri,
            namespace: namespace
          }
        end

        Sidekiq.configure_client do |config|
          config.redis = {
            url: uri,
            namespace: namespace
          }
        end
      end
    end
  end
end
