# SuningPay

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/suning_pay`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

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
    
## API

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

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/suning_pay. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SuningPay project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/suning_pay/blob/master/CODE_OF_CONDUCT.md).
