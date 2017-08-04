class SuningPay::Railtie < Rails::Railtie
  rake_tasks do
    load 'rake/suning_pay.rake'
  end
end