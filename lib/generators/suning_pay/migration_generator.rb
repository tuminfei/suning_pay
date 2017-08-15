require 'rails/generators/active_record'

class SuningPay::MigrationGenerator < ::Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)
  desc 'Installs SuningPay migration file.'

  def install
    migration_template 'migration.rb', 'db/migrate/create_suning_pay_notices.rb'
  end

  def self.next_migration_number(dirname)
    ActiveRecord::Generators::Base.next_migration_number(dirname)
  end
end
