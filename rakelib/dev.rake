# frozen_string_literal: true

require_relative '../config/base'

namespace :test do
  desc 'Executa os testes'
  task :run do
    system('RAKE_ENV=test bundle exec rspec')
  rescue StandardError => e
    puts "Erro => #{e.message}"
  end
end

desc 'Tasks usadas para o ambiente de desenvolvimento & testes'
namespace :dev do
  desc 'Roda o rubycritic'
  task :rubycritic do
    system('bundle exec rubycritic domain/ models/ app.rb')
  rescue StandardError => e
    puts "Erro => #{e.message}"
  end

  desc 'Gera a documentação com Yard e executa seu server'
  task :yard do
    system('bundle exec yardoc domain/**/* models/**/* app.rb && bundle exec yard server')
  rescue StandardError => e
    puts "Erro => #{e.message}"
  end
end

desc 'Exibe as rotas disponíveis'
task :routes do
  require 'json'
  routes_filename = 'routes.json'
  system("roda-parse_routes -f #{routes_filename} app.rb")
  rotas = JSON.parse(File.read("#{APP_ROOT}/#{routes_filename}"))
  ap rotas
rescue StandardError => e
  puts "Erro => #{e.message}"
end

task default: ['test:run']
