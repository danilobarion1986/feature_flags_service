# frozen_string_literal: true

require_relative '../config/base'

desc 'Database tasks'
namespace :db do
  MIGRATIONS_PATH = "#{APP_ROOT}/db/migrations"

  def wait_for_pg!
    command = "psql -h #{ENV['PGHOST']} -p #{ENV['PGPORT']} -U #{ENV['PGUSER']} -e postgres -c '\\q'"

    until (result = system("PGPASSWORD=#{ENV['POSTGRES_PASSWORD']} #{command}"))
      puts "Postgres is unavailable - sleeping"
      sleep 1
    end
  end

  desc 'Create the database for the given environment'
  task :create do
    puts 'Creating database...'
    wait_for_pg!
    system("createdb -w -e #{ENV['PGDATABASE']}")
  rescue StandardError => e
    puts "Error => #{e.message}"
  end

  desc 'Drop the database for the given environment'
  task :drop do
    puts 'Dropping database...'
    wait_for_pg!
    system("dropdb --if-exists -w -e #{ENV['PGDATABASE']}")
  rescue StandardError => e
    puts "Error => #{e.message}"
  end

  desc 'Execute all pending migrations. With the "true" parameter, it ignores missing migration files'
  task :migrate, [:ignore_missing] do |_t, args|
    wait_for_pg!

    require_relative '../config/sequel'
    Sequel.extension :migration

    extra_params = { allow_missing_migration_files: args[:ignore_missing] }.compact
    Sequel::Migrator.run(DB, MIGRATIONS_PATH, extra_params)
  rescue Sequel::Migrator::Error => e
    puts "Error => #{e.message}"
  end

  desc 'Reset the database state, executing the "down" block of each migration'
  task :reset do
    wait_for_pg!

    require_relative '../config/sequel'
    Sequel.extension :migration

    Sequel::Migrator.run(DB, MIGRATIONS_PATH, target: 0)
  rescue Sequel::Migrator::Error => e
    puts "Error => #{e.message}"
  end

  desc 'Populates the database using the file "db/seeds.rb"'
  task :seed do
    wait_for_pg!

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
