##################TEST##################
#接口地址
SuningPay.api_base_url = 'https://ebanksandbox.suning.com/epps-ebpg/api/contract/'
SuningPay.api_query_base_url  = 'https://paymentsandbox.suning.com/epps-pag/apiGateway/merchantOrder/'
SuningPay.api_tranfer_url = 'https://wagtestpre.suning.com/epps-twg/'
#客户号
SuningPay.merchant_no = '70057278'
#Suning证书存放路径
SuningPay.api_suning_cert = '/Users/terry/Documents/RUBY/hex/yifubao-pre.cer'
#客户端RSA 公钥,1024, pem文件路径
SuningPay.api_client_public_key = '/Users/terry/Documents/RUBY/hex/rsa_public_key.pem'
#客户端RSA 私钥,1024, pem文件路径
SuningPay.api_client_private_key = '/Users/terry/Documents/RUBY/hex/rsa_private_key.pem'

##################PROD##################
#SuningPay.api_base_url = 'https://ebankpay.suning.com/epps-ebpg/api/contract/'
#SuningPay.api_query_base_url  = 'https://payment.suning.com/epps-pag/apiGateway/merchantOrder/'
#SuningPay.api_tranfer_url = 'https://tag.yifubao.com/epps-twg/'

#SuningPay.merchant_no = ''
#SuningPay.api_suning_cert = ''
#SuningPay.api_client_public_key = ''
#SuningPay.api_client_private_key = ''

#SuningPay.debug_mode = false
