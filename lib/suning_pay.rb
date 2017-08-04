require 'uri'
require 'openssl'
require 'digest/md5'
require 'base64'

require "suning_pay/version"
require "suning_pay/rsa"
require "suning_pay/service"
require "suning_pay/railtie" if defined?(Rails)

module SuningPay
  @client_options = {}
  @debug_mode = true
  @public_key_index = '0001'
  @version = '1.0'
  @input_charset = 'UTF-8'

  class<< self
    attr_accessor :merchant_no, :signature, :sign_algorithm, :submit_time, :debug_mode
    attr_reader :api_base_url, :api_suning_cert, :api_suning_public_key, :api_client_public_key, :api_client_private_key

    def api_base_url=(url)
      @api_base_url = url
    end

    def api_suning_cert=(cert_path)
      unless cert_path.blank?
        cert = File.read cert_path
        @api_suning_cert = OpenSSL::X509::Certificate.new(cert)
        @api_suning_public_key = @api_suning_cert.public_key
      end
    end

    def api_client_public_key=(key_path)
      unless key_path.blank?
        key = File.read key_path
        @api_client_public_key = OpenSSL::PKey::RSA.new(key)
      end
    end

    def api_client_private_key=(key_path)
      unless key_path.blank?
        key = File.read key_path
        @api_client_private_key = OpenSSL::PKey::RSA.new(key)
      end
    end

    def debug_mode?
      @debug_mode
    end

    def client_options
      options = {:merchantNo => @merchant_no,
                 :publicKeyIndex => @public_key_index,
                 :version => @version,
                 :inputCharset => @input_charset,
                 :submitTime => Time.now.strftime("%Y%m%d%H%M%S")
      }

      @client_options = options
      @client_options
    end
  end
end
