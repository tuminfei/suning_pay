module SuningPay
  class Engine < ::Rails::Engine
    isolate_namespace SuningPay

    initializer 'SuningPay', group: :all do |app|
      Rails.application.routes.prepend do
        mount SuningPay::Engine, at: '/api/suning_pay'
      end
    end
  end
end

