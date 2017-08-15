SuningPay::Engine.routes.draw do
  post "notify" => "notify#index"
end