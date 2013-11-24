module Urayon
  class Handler < ::EventMachine::Connection
    def post_init
      @buffer = []
      @connected = false
    end

    def peer
      @peer ||=
        begin
          port, ip = Socket.unpack_sockaddr_in(get_peername)
          "#{ip}:#{port}"
        end
    end

    def receive_data(data)
      if !@connected
        @buffer << data
        binding.pry
        Sidekiq::Client.enqueue_to($config.namespace, ForwardWorker, prepare_data(@buffer.join))
        close_connection
      end
    rescue => e
      close_connection
      LOGGER.info "#{e.class} - #{e.message}"
    end

    def prepare_data(data)
      {
        source_data: data,
        forward_to_host: $config.forward_to_host,
        forward_to_port: $config.forward_to_port
      }.to_json
    end
  end
end
