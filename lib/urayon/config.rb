module Urayon
  class Config

    def initialize(options)
      @config = YAML.load_file(File.join(ROOT_PATH, 'config.yml'))

      #binding.pry
      @resque     = {
        uri:       options.delete(:resque_uri) || @config["resque"]["uri"]       || DEFAULT_RESQUE_URI,
        namespace: options.delete(:namespace)  || @config["resque"]["namespace"] || DEFAULT_RESQUE_NAMESPACE
      }
      @from        = {
        host: (options.delete(:host) || @config["listen"]["host"] || DEFAULT_HOST),
        port: (options.delete(:port) || @config["listen"]["port"] || DEFAULT_PORT)
      }
      @to          = {
        host: options.delete(:forward_to_host) || @config["forward"]["host"],
        port: options.delete(:forward_to_port) || @config["forward"]["host"]
      }
    end
    def resque_uri;       @resque[:uri];       end
    def resque_namespece; @resque[:namespace]; end
    def listen_host;      @from[:host];        end
    def listen_port;      @from[:port];        end
    def forward_to_host;  @to[:host];          end
    def forward_to_port;  @to[:port];          end
  end
end
