#encoding: utf-8
module SuningPay
  class Service
    CURRENCY_CNY = 'CNY'
    PAYTYPE_IM = '01'

    #1.签约请求_发送短信接口
    def self.post_send_msg(bank_code, card_type, card_info, tunnel_data = '', options = {})
      #加密cardinfo
      suning_pub_key = SuningPay.api_suning_public_key
      encr_msg = SuningPay::RSA.encrypt_msg(suning_pub_key, card_info)

      input_hash = {:bankCode => bank_code,
                    :cardType => card_type,
                    :cardInfo => encr_msg,
                    :tunnelData => Base64.urlsafe_encode64(tunnel_data)}

      post_params = SuningPay.client_options.merge(options).merge(input_hash)
      #调用查询接口
      msg = SuningPay::Util.send_post('sendMsg', post_params)
      msg
    end

    #2.签约请求_验证短信接口
    def self.post_validate_sign(smg_code, serial_no, tunnel_data = '', options = {})
      input_hash = {:smgCode => smg_code,
                    :serialNo => serial_no,
                    :tunnelData => Base64.urlsafe_encode64(tunnel_data)}
      post_params = SuningPay.client_options.merge(options).merge(input_hash)
      #调用查询接口
      msg = SuningPay::Util.send_post('validateSign', post_params)
      msg
    end

    #3.签约请求接口(易付宝不发短信)
    def self.post_sign(bank_code, card_type, card_info, tunnel_data = '', options = {})
      #加密cardinfo
      suning_pub_key = SuningPay.api_suning_public_key
      encr_msg = SuningPay::RSA.encrypt_msg(suning_pub_key, card_info)

      input_hash = {:bankCode => bank_code,
                    :cardType => card_type,
                    :cardInfo => encr_msg,
                    :tunnelData => Base64.urlsafe_encode64(tunnel_data)}

      post_params = SuningPay.client_options.merge(options).merge(input_hash)
      #调用查询接口
      msg = SuningPay::Util.send_post('sign', post_params)
      msg
    end

    #4.解约请求接口
    def self.post_cancel(contract_no, tunnel_data = '', options = {})
      input_hash = {:contractNo => contract_no,
                    :tunnelData => Base64.urlsafe_encode64(tunnel_data)}
      post_params = SuningPay.client_options.merge(options).merge(input_hash)
      #调用查询接口
      msg = SuningPay::Util.send_post('cancel', post_params)
      msg
    end

    #5.支付订单请求(默认使用2.0版本)
    def self.post_pay(contract_no, out_order_no, order_type, order_amount, order_time, saler_merchant_no, goods_type, goods_name, pay_timeout, remark, tunnel_data = '', options = {:version => '2.0'})
      input_hash = {:contractNo => contract_no,
                    :outOrderNo => out_order_no,
                    :orderType => order_type,
                    :orderAmount => order_amount,
                    :orderTime => order_time,
                    :currency => CURRENCY_CNY,
                    :salerMerchantNo => saler_merchant_no,
                    :goodsType => goods_type,
                    :goodsName => Base64.urlsafe_encode64(goods_name),
                    :payTimeout => pay_timeout,
                    :remark => Base64.urlsafe_encode64(remark),
                    :tunnelData => Base64.urlsafe_encode64(tunnel_data)}

      post_params = SuningPay.client_options.merge(options).merge(input_hash)
      #调用查询接口
      msg = SuningPay::Util.send_post('pay', post_params)
      msg
    end

    #6.支付订单查询接口
    def self.post_query_merchant_order(out_order_no, order_time, options = {:version => '1.2'})
      input_hash = {:outOrderNo => out_order_no,
                    :orderTime => order_time}

      post_params = SuningPay.client_options.merge(options).merge(input_hash)
      #调用查询接口
      msg = SuningPay::Util.send_post('queryMerchantOrder.do', post_params, SuningPay::API_CODE_Q_PAY)
      msg
    end

    #7.支持银行查询接口
    def self.post_query_channel(product_code, options = {})
      input_hash = {:productCode => product_code}
      post_params = SuningPay.client_options.merge(options).merge(input_hash)
      #调用查询接口
      msg = SuningPay::Util.send_post('queryChannel', post_params)
      msg
    end

  end
end
