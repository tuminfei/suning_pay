#encoding: utf-8
require 'digest/md5'
require 'base64'

module SuningPay
  class Service
    CURRENCY_CNY = 'CNY'

    #1.签约请求_发送短信接口
    def self.post_send_msg(bank_code, card_type, card_info, tunnel_data=nil, options = {})
      #加密cardinfo
      suning_pub_key = SuningPay.api_suning_public_key
      encr_msg = SuningPay::RSA.encrypt_msg(suning_pub_key, card_info)

      input_hash = {:bankCode => bank_code,
                    :cardType => card_type,
                    :cardInfo => encr_msg,
                    :tunnelData => Base64.urlsafe_encode64(tunnel_data)}

      post_params = SuningPay.client_options.merge(options).merge(input_hash)
      #调用查询接口
      msg = send_post('sendMsg', post_params)
      msg
    end

    #2.签约请求_验证短信接口
    def self.post_validate_sign(smg_code, serial_no, tunnel_data=nil, options = {})
      input_hash = {:smgCode => smg_code,
                    :serialNo => serial_no,
                    :tunnelData => Base64.urlsafe_encode64(tunnel_data)}
      post_params = SuningPay.client_options.merge(options).merge(input_hash)
      #调用查询接口
      msg = send_post('validateSign', post_params)
      msg
    end

    #3.签约请求接口(易付宝不发短信)
    def self.post_sign(bank_code, card_type, card_info, tunnel_data=nil, options = {})
      #加密cardinfo
      suning_pub_key = SuningPay.api_suning_public_key
      encr_msg = SuningPay::RSA.encrypt_msg(suning_pub_key, card_info)

      input_hash = {:bankCode => bank_code,
                    :cardType => card_type,
                    :cardInfo => encr_msg,
                    :tunnelData => Base64.urlsafe_encode64(tunnel_data)}

      post_params = SuningPay.client_options.merge(options).merge(input_hash)
      #调用查询接口
      msg = send_post('sign', post_params)

    end

    #4.解约请求接口
    def self.post_cancel(contract_no, tunnel_data=nil, options = {})
      input_hash = {:contractNo => contract_no,
                    :tunnelData => Base64.urlsafe_encode64(tunnel_data)}
      post_params = SuningPay.client_options.merge(options).merge(input_hash)
      #调用查询接口
      msg = send_post('cancel', post_params)
      msg
    end

    #5.支付订单请求
    def self.post_pay(contract_no, out_order_no, order_type, order_amount, order_time, saler_merchant_no, goods_type, goods_name, pay_timeout, remark, tunnel_data=nil, options = {})
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
                    :remark => remark,
                    :tunnelData => Base64.urlsafe_encode64(tunnel_data)}

      post_params = SuningPay.client_options.merge(options).merge(input_hash)
      #调用查询接口
      msg = send_post('pay', post_params)
      msg
    end

    #6.支付订单查询接口
    def self.post_query_merchant_order(out_order_no, order_time, options = {})
      input_hash = {:outOrderNo => out_order_no,
                    :orderTime => order_time}

      post_params = SuningPay.client_options.merge(options).merge(input_hash)
      #调用查询接口
      msg = send_post('queryMerchantOrder.do', post_params)
      msg
    end

    #7.支持银行查询接口
    def self.post_query_channel(product_code, options = {})
      input_hash = {:productCode => product_code}
      post_params = SuningPay.client_options.merge(options).merge(input_hash)
      #调用查询接口
      msg = send_post('queryChannel', post_params)
      msg
    end


    private
    #生成md5摘要信息
    def get_summary(params)
      #排序
      data_hash = sorted_hash(params)
      #拼接
      data_arr = []
      data_hash.each do |k,v|
        data_arr << k.to_s + '=' + v.to_s
      end
      data_str = data_arr.join('&')
      #MD5摘要
      data_md5 =  Digest::MD5.hexdigest(data_str).upcase
      data_md5
    end

    #生成带摘要签名的查询参数
    def signature_param(prams, summary)
      #私钥加密
      private_key = SuningPay.api_client_private_key
      sign = private_key.sign('sha1',summary.force_encoding("utf-8"))
      #Base64编码后取出后'-'
      signature = Base64.urlsafe_encode64(sign).gsub!(/=+$/, "")
      data_sign = {:signature => signature, :signAlgorithm => 'RSA'}
      params_signed = prams.merge(data_sign)
      params_signed
    end

    #排序
    def sorted_hash(in_hash)
      return in_hash.sort{|a,b| a.to_s <=> b.to_s  }
    end

    def send_post(func_name, func_params_hash)
      #对params就行摘要并签名
      summary = get_summary(func_params_hash)
      #加签名的查询参数
      func_params = signature_param(func_params_hash, summary)

      api_url = SuningPay.api_base_url + '/' + func_name
      conn = Faraday.new(:url => api_url)

      response = conn.post '', func_params
      html_response = response.body
      html_response
    end
  end
end
