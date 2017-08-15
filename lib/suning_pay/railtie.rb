#encoding: utf-8
module SuningPay
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'rake/suning_pay.rake'
    end
  end
end
