require "test_helper"

class SuningPayTest < Minitest::Test
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

  def test_it_does_something_useful
    assert false
  end
end
