# frozen_string_literal: true

require_relative '../config/base'

desc 'Database tasks'
namespace :db do
  migrations_path = "#{APP_ROOT}/db/migrations"
  user = ENV['POSTGRES_USER']
  db = ENV['POSTGRES_DB']

  desc 'Create the database for the given environment'
  task :create do
    system("docker exec -ti roda_db psql -U #{user} -c 'CREATE DATABASE #{db};'")
  end

  desc 'Drop the database for the given environment'
  task :drop do
    system("docker exec -ti roda_db psql -U #{user} -c 'DROP DATABASE #{db};'")
  rescue StandardError => e
    puts "Error => #{e.message}"
  end

  desc 'Execute all pending migrations. With the "true" parameter, it ignores missing migration files'
  task :migrate, [:ignore_missing] do |_t, args|
    require_relative '../config/sequel'
    Sequel.extension :migration

    extra_params = { allow_missing_migration_files: args[:ignore_missing] }.compact
    Sequel::Migrator.run(DB, migrations_path, extra_params)
  rescue Sequel::Migrator::Error => e
    puts "Error => #{e.message}"
  end

  desc 'Reset the database state, executing the "down" block of each migration'
  task :reset do
    require_relative '../config/sequel'
    Sequel.extension :migration

    Sequel::Migrator.run(DB, migrations_path, target: 0)
  rescue Sequel::Migrator::Error => e
    puts "Error => #{e.message}"
  end

  desc 'Populates the database using the file "db/seeds.rb"'
  task :seed do
    require_relative '../config/sequel'

    Db::Seeds.call
  rescue StandardError => e
    puts "Error => #{e.message}"
  end

  desc 'Drop, create and set up the database from the scratch'
  task :setup do
    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
  rescue StandardError => e
    puts "Error => #{e.message}"
  end
end
