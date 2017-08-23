# SuningPay

SuningPay(易付宝) API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'suning_pay'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install suning_pay
    
Add init file (suning_pay.rb) to Rails config/initializers

    rake suning_pay:init:create
    
Configuration

```ruby
##################TEST##################
#接口地址-委托代收
SuningPay.api_base_url = 'https://ebanksandbox.suning.com/epps-ebpg/api/contract/'
SuningPay.api_query_base_url  = 'https://paymentsandbox.suning.com/epps-pag/apiGateway/merchantOrder/'
#接口地址-批量付款
SuningPay.api_tranfer_url = 'https://wagtestpre.suning.com/epps-twg/'
SuningPay.api_card_tranfer_url ='https://wagtestpre.suning.com/epps-wag/'
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
#SuningPay.api_card_tranfer_url ='https://wag.yifubao.com/epps-wag/'

#SuningPay.merchant_no = ''
#SuningPay.api_suning_cert = ''
#SuningPay.api_client_public_key = ''
#SuningPay.api_client_private_key = ''

#SuningPay.debug_mode = false
```

Add Migration
```ruby
rails g suning_pay:migration
```

    
## API-委托代收

1. 签约请求_发送短信接口
2. 签约请求_验证短信接口
3. 签约请求接口(易付宝不发短信)
4. 解约请求接口
5. 支付订单请求(已签约)
6. 支付订单查询接口
7. 支持银行查询接口

```ruby
SuningPay::Service.post_send_msg
SuningPay::Service.post_validate_sign
SuningPay::Service.post_sign
SuningPay::Service.post_cancel
SuningPay::Service.post_pay
SuningPay::Service.post_query_merchant_order
SuningPay::Service.post_query_channel
```

## API-企业批量付款

1. 批量转账下单接口
2. 批量出款到卡接口
3. 转账批次查询接口
4. 出款批次查询接口

```ruby
SuningPay::EntService.post_transfer_acquire
SuningPay::EntService.post_withdraw
SuningPay::EntService.post_transfer_query
SuningPay::EntService.post_withdraw_query
```

##Notice_API
```ruby
rails g suning_pay:migration
```

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tuminfei/suning_pay. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SuningPay project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/suning_pay/blob/master/CODE_OF_CONDUCT.md).
