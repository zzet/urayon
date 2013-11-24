require "urayon/version"

require 'yaml'
require 'eventmachine'
require 'logger'
require 'socket'
require 'sidekiq'
require 'pry'

require "urayon/initializer"
require "urayon/config"
require "urayon/daemon"
require "urayon/handler"
require "urayon/forward_worker"

module Urayon
  DEFAULT_HOST              = "0.0.0.0"
  DEFAULT_PORT              = "8080"
  DEFAULT_RESQUE_URI        = "redis://localhost:6379"
  DEFAULT_RESQUE_NAMESPACE  = "urayon"
  MAX_FAST_SHUTDOWN_SECONDS = 10
  ROOT_PATH                 = File.expand_path(File.join(File.dirname(__FILE__), ".."))
  LOGGER                    = Logger.new(STDOUT)
end
