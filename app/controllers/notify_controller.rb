module SuningPay
  class NotifyController < ::ActionController::Base
    if _process_action_callbacks.any?{|a| a.filter == :verify_authenticity_token}
      # ActionController::Base no longer protects from forgery in Rails 5
      skip_before_filter :verify_authenticity_token
    end

    layout false

    def index
      SuningPay::Notice.create(:content => params[:content], :sign=>params[:sign], :sign_type=>params[:sign_type], :vk_version=>params[:vk_version])
      render text: 'true'
    end
  end
end
