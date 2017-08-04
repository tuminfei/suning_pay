require 'fileutils'

namespace :suning_pay do
  namespace :init do
    desc "Generate suning_pay init file from example"
    task :create do
      source = File.join(Gem.loaded_specs["suning_pay"].full_gem_path, "suning_pay.rb")
      target = File.join(Rails.root, "config", "initializers", "suning_pay.rb")
      FileUtils.cp_r source, target
    end

  end
end