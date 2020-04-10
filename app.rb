# frozen_string_literal: true

require_relative './config/application'

# Class with the routing tree
class App < Roda
  # https://github.com/jeremyevans/roda/blob/master/lib/roda/plugins/environments.rb
  plugin :environments

  # If you need more HTTP verbs than GET/POST
  plugin :all_verbs

  # For rails-style "*_path" methods and other useful stuff
  # https://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins/Path.html
  # plugin :path

  # For basic authentication: https://github.com/badosu/roda-basic-auth
  # plugin :basic_auth

  plugin :json, classes: [Array, Hash, Sequel::Model]
  plugin :symbol_matchers
  plugin :error_handler
  plugin :status_handler
  plugin :hooks
  plugin :slash_path_empty
  plugin :common_logger, $stdout

  after do |_res|
    if defined?(@start_time)
      request_time = clock_time - @start_time
      puts "[request_time] => #{request_time.round(5)} ms"
    end
  end

  error do |e|
    { error: e.message }
  end

  status_handler(403) do
    'Forbidden'
  end

  status_handler(404) do
    'Not Found'
  end

  configure :development, :test do
    require 'pry'
    require 'awesome_print'
    plugin :exception_page
  end

  route do |r|
    r.root do
      r.redirect '/healthcheck'
    end

    # route: GET /healthcheck
    r.is 'healthcheck' do
      Domain::Healthcheck.call
    end

    r.on 'v1' do
      r.on 'domain' do
        # route: GET /v1/domain/:domain_id
        r.get :d do |domain_id|
          { domain: Models::YourModel.where(id: domain_id).first || {} }
        end

        r.is do
          # route: GET /v1/domain
          r.get do
            @start_time = clock_time
            { domain: Models::YourModel.all }
          end
        end
      end
    end
  end

  def clock_time
    Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end
end
