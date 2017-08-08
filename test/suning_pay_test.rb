require "test_helper"

class SuningPayTest < Minitest::Test

  CARD_INFO = '{"cardHolderName": "黄晓明", "certType": "01","certNo": "330726196507040016", "mobileNo": "18651661234", "cardNo": "8000000000000000210", "expYear": "18","expMonth": "06","cvv": "123"}'

  def setup
    SuningPay.api_base_url = 'https://ebanksandbox.suning.com/epps-ebpg/api/contract/'
    SuningPay.api_query_base_url  = 'https://paymentsandbox.suning.com/epps-pag/apiGateway/merchantOrder/'
    SuningPay.api_tranfer_url = 'https://wagtestpre.suning.com/epps-twg/'
    SuningPay.api_card_tranfer_url ='https://wagtestpre.suning.com/epps-wag/'
    SuningPay.merchant_no = '70057278'
    data_path = File.expand_path("../../data", __FILE__)

    SuningPay.api_suning_cert = "#{data_path}/yifubao-pre.cer"
    SuningPay.api_client_public_key = "#{data_path}/rsa_public_key.pem"
    SuningPay.api_client_private_key = "#{data_path}/rsa_private_key.pem"
    puts '-------------------------init-------------------------'
  end

  def test_that_it_has_a_version_number
    refute_nil ::SuningPay::VERSION
  end

  def test_init
    SuningPay.api_base_url = 'https://ebanksandbox.suning.com/epps-ebpg/api/contract/'
    SuningPay.api_query_base_url  = 'https://paymentsandbox.suning.com/epps-pag/apiGateway/merchantOrder/'
    SuningPay.api_tranfer_url = 'https://wagtestpre.suning.com/epps-twg/'
    SuningPay.api_card_tranfer_url ='https://wagtestpre.suning.com/epps-wag/'

    assert_equal(SuningPay.api_base_url, 'https://ebanksandbox.suning.com/epps-ebpg/api/contract/')
    assert_equal(SuningPay.api_query_base_url, 'https://paymentsandbox.suning.com/epps-pag/apiGateway/merchantOrder/')
    assert_equal(SuningPay.api_tranfer_url, 'https://wagtestpre.suning.com/epps-twg/')
    assert_equal(SuningPay.api_card_tranfer_url, 'https://wagtestpre.suning.com/epps-wag/')
  end

  def test_service_post_send_msg
    #rep = SuningPay::Service.post_send_msg('TEST_KJ', '1', CARD_INFO,'123')
  end
end
