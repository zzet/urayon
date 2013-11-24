module Urayon
  class Daemon
    def initialize(config)
      @listen_host  = config.listen_host
      @listen_port  = config.listen_port

      @server       = nil
    end

    def start
      EventMachine::run do
        @server = EventMachine::start_server(@listen_host, @listen_port, Handler)
        LOGGER.info "Start listening on #{@listen_host}:#{@listen_port}"

        trap('QUIT') do
          self.graceful_shutdown('QUIT')
        end
        trap('TERM') do
          self.fast_shutdown('TERM')
        end
        trap('INT') do
          self.fast_shutdown('INT')
        end
      end
    end

    def graceful_shutdown(signal)
      EM.stop_server(@server) if @server
      LOGGER.info "Received #{signal} signal. No longer accepting new connections."
      #p "Waiting for #{ProxyMachine.count} connections to finish."
      @server = nil
      EM.stop # if ProxyMachine.count == 0
    end

    def fast_shutdown(signal)
      EM.stop_server(@server) if @server
      LOGGER.info "Received #{signal} signal. No longer accepting new connections."
      LOGGER.info "Maximum time to wait for connections is #{MAX_FAST_SHUTDOWN_SECONDS} seconds."
      #p "Waiting for #{ProxyMachine.count} connections to finish."
      @server = nil
      EM.stop #if ProxyMachine.count == 0
      Thread.new do
        sleep MAX_FAST_SHUTDOWN_SECONDS
        exit!
      end
    end
  end
end
