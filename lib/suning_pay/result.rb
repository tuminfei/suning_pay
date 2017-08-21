#encoding: utf-8
module SuningPay
  class Result < ::Hash
    RESULT_SUCCESS_FLAG = '0000'
    RESULT_ERR_FLAG = '9999'
    PAY_SUCCESS_FLAG = 'S'
    PAY_FAILURE_FLAG = 'F'
    PAY_PENDING_FLAG = 'P'
    PAY_CLOSE_FLAG = 'C'

    RESULT_MSG = {
        '0000' => '成功',
        '0140' => '不支持该业务',
        '0160' => '未开通支付方式',
        '0161' => '渠道维护关闭',
        '0162' => '服务维护中',
        '0360' => '订单已失效',
        '0400' => '请检查银行卡号是否正确',
        '0401' => '请检查银行编码、卡类型是否正确',
        '0430' => '该银行卡已签约',
        '0431' => '请重新 交签约申请',
        '0432' => '未绑定银行卡，请签约后交支付',
        '0440' => '订单金额超过银行限额',
        '0501' => '渠道维护升级中',
        '0596' => '支付处理中，请稍后查询',
        '0597' => '服务处理中，请稍后查询',
        '0598' => '请求参数不合法',
        '0599' => '系统异常，请稍后查询',
        '2121' => '支付处理中，请稍后查询订单状态',
        '2125' => '支付处理中，请稍后查询订单状态',
        '2126' => '支付处理中，请稍后查询订单状态',
        '3600' => '风控额度校验不通过',
        '3610' => '风控未配置额度，不通过',
        '6218' => '银行返回超时，请稍后查询',
        '6601' => '验签失败',
        '6611' => '验签失败',
        '6804' => '商户不存在有效合同',
        '7401' => '查询商户信息失败',
        '8001' => '支付失败',
        '8007' => '支付失败',
        '8015' => '支付失败',
        '8016' => '银行处理中，请稍后查询',
        '8021' => '银行卡余额不足',
        '8022' => '交易金额超过银行限额',
        '8025' => '交易金额低于银行最低要求',
        '8053' => '24 小时内银行卡余额不足次数超限',
        '8054' => '该卡当日失败次数超限',
        '8055' => '同一卡号单位时间内交易次数过高，请降低提交频次',
        '8060' => '黑名单用户',
        '8068' => '发卡行交易权限受限，详情请咨询您的发卡行',
        '8074' => '非白名单用户',
        '8075' => '银行卡已挂失，请更换其他付款方式',
        '8090' => '交易失败，请联系银行',
        '8093' => '银行扣款失败',
        '8104' => '银行正在进行日终处理，请稍后重试',
        '8105' => '通道不支持该笔交易',
        '8106' => '无可用渠道',
        '8107' => '无匹配路由',
        '8120' => '银行卡号不正确',
        '8125' => '与银行预留的证件号不符',
        '8127' => '与银行预留的信息不符，请核实后重新提交',
        '8147' => '银行卡状态异常，请更换其他付款方式',
        '8160' => '支付金额超过日累计限额',
        '9996' => '系统处理超时，请稍后查询',
        '9997' => '交易处理中，请稍后查询',
        '9998' => '交易处理中，请稍后查询',
        '9999' => '系统处理异常，请稍后查询'
    }

    def initialize(result)
      super nil
      self[:raw] = result

      if result.class == Hash
        result.each do |k, v|
          self[k] = v
        end
      end
    end

    def msg_code
      self['responseCode']
    end

    def msg_info
      self['responseMsg']
    end

    def success?
      self['responseCode'] == RESULT_SUCCESS_FLAG
    end

    def pay_success?
      self['responseCode'] == RESULT_SUCCESS_FLAG and self['payResult'] == PAY_SUCCESS_FLAG
    end

    def pay_fail?
      self['responseCode'] == RESULT_SUCCESS_FLAG and self['payResult'] == PAY_FAILURE_FLAG
    end

    def order_success?
      self['responseCode'] == RESULT_SUCCESS_FLAG and self['orderStatus'] == PAY_SUCCESS_FLAG
    end

    def order_close?
      self['responseCode'] == RESULT_SUCCESS_FLAG and self['orderStatus'] == PAY_CLOSE_FLAG
    end
  end
end