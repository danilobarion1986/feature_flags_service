# frozen_string_literal: true

require 'roda'
require 'pathname'
require 'zeitwerk'
require 'dry/schema'
require 'dotenv'
require 'pry'
require 'awesome_print'
require 'erb'

Dotenv.load(".env.#{ENV['RACK_ENV'] || :development}")

APP_ROOT = Pathname.new(File.expand_path('..', __dir__))
GIT_TAG = File.readlines(File.join(APP_ROOT, 'versao')).first.chomp

database_yml = File.join(APP_ROOT, 'config', 'database.yml')
CONNECTION_OPTIONS = YAML.safe_load(ERB.new(File.read(database_yml)).result)[ENV['RACK_ENV']]

# https://github.com/fxn/zeitwerk/blob/master/README.md
loader = Zeitwerk::Loader.new
loader.push_dir(APP_ROOT)
loader.enable_reloading
loader.setup
