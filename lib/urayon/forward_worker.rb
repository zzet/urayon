module Urayon
  class ForwardWorker
    include Sidekiq::Worker
    def perform(data)
      p data
      data            = JSON.load(data).stringify_keys
      p data
      forward_to_host = data["forward_to_host"]
      forward_to_port = data["forward_to_port"]
      request         = data["source_data"]
      p request
      #Forwarder.send_request(forward_to_host, forward_to_port, request)
    end
  end
end
