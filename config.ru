# frozen_string_literal: true

require_relative './app'

use Rack::Reloader, 0
use Rack::Runtime

$LOAD_PATH.unshift('.')
run App.freeze.app
