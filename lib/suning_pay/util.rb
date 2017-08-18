#encoding: utf-8
require 'logger'

module SuningPay
  class Util
    DEFAULT_ERR_MSG = '{"responseMsg":"系统处理异常，请稍后查询","responseCode":"9999"}'

    #生成md5摘要信息
    def self.get_summary(params)
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
    def self.signature_param(prams, summary)
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
    def self.sorted_hash(in_hash)
      return in_hash.sort{|a,b| a.to_s <=> b.to_s  }
    end

    #发送请求
    def self.send_post(func_name, func_params_hash, api_code=SuningPay::API_CODE_PAY)
      api_url = ''

      case api_code
        when SuningPay::API_CODE_PAY
          api_url = SuningPay.api_base_url  + func_name
        when SuningPay::API_CODE_Q_PAY
          api_url = SuningPay.api_query_base_url + func_name
        when SuningPay::API_CODE_TRANSFER
          api_url = SuningPay.api_tranfer_url + func_name
        when SuningPay::API_CODE_TRANSFER_CARD
          api_url = SuningPay.api_card_tranfer_url + func_name
        else
          api_url = SuningPay.api_base_url + func_name
      end

      #对params就行摘要并签名
      summary = get_summary(func_params_hash)
      #加签名的查询参数
      func_params = signature_param(func_params_hash, summary)
      conn = Faraday.new(:url => api_url)

      response = conn.post '', func_params
      html_response = response.body

      if SuningPay.debug_mode
        logger = Logger.new('suning_pay.log')
        logger.info('--------------SUNING PAY DEBUG--------------')
        logger.info("URL:#{api_url.to_s}")
        logger.info("PARAMS:#{func_params.to_s}")
        logger.info("RESPONSE:#{html_response.force_encoding('UTF-8')}")
      end

      begin
        msg = JSON.parse(html_response)
      rescue JSON::ParserError => e
        msg = JSON.parse(DEFAULT_ERR_MSG)
      end
      msg
    end
  end
end
