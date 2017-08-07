#encoding: utf-8
module SuningPay
  class EntService
    CURRENCY_CNY = 'CNY'
    PAY_CHARGE_MODE_OUT = '01'
    PAY_CHARGE_MODE_IN = '02'
    PAY_CHARGE_MODE_TRAN = '03'
    ACCOUNT_TYPE_PERSON = 'PERSON'
    ACCOUNT_TYPE_CORP = 'CORP'

    #1.批量转账下单接口
    # batch_list格式为交易数组。
    # [
    #   [转账流水号1, 收款方易付宝登录名, 收款方商户号, 收款方姓名, 转账金额, 收款方类型, 备注信息, 订单名称],
    #   [转账流水号2, 收款方易付宝登录名, 收款方商户号, 收款方姓名, 转账金额, 收款方类型, 备注信息, 订单名称]
    # ]
    def self.post_transfer_acquire(batch_no, product_code, charge_mode, goods_type, batch_order_name, batch_list = [], notify_url = nil, tunnel_data = nil, options = {})

      raise ArgumentError, "Argument batch_list error" if batch_list.nil? or batch_list.empty?

      raise ArgumentError, "Argument batch_list count limit 1000" if batch_list.size > 1000

      body = {}
      detail_data = []
      #合计交易数据
      total_num = batch_list.size
      total_amount = 0
      batch_list.each {|x| total_amount += x[4]}

      batch_list.each do |tran|
        detail_line = {
            "serialNo" => tran[0],
            "receiverLoginName" => tran[1],
            "receiverNo" => tran[2],
            "receiverName" => tran[3],
            "amount" => tran[4],
            "receiverType" => tran[5],
            "remark" => tran[6],
            "orderName" => tran[7]
        }
        detail_data << detail_line
      end

      #body参数
      body = {
          :batchNo => batch_no,
          :merchantNo => SuningPay.merchant_no,
          :productCode => product_code,
          :totalNum => total_num,
          :totalAmount => total_amount,
          :currency => SuningPay::EntService::CURRENCY_CNY,
          :chargeMode => charge_mode,
          :payDate => Time.now.strftime("%Y%m%d%"),
          :tunnelData => tunnel_data,
          :detailData => detail_data.to_s,
          :goodsType => goods_type,
          :batchOrderName => batch_order_name,
          :notifyUrl => notify_url
      }

      input_hash = {:merchantNo => SuningPay.merchant_no,
                    :body => body.to_s}
      post_params = SuningPay.ent_options.merge(options).merge(input_hash)

      #调用查询接口
      msg = SuningPay::Util.send_post('transferAcquire.htm', post_params, SuningPay::API_CODE_TRANSFER)
      msg
    end

    #2.批量出款到卡接口
    def self.post_withdraw()

    end

    #3.转账批次查询接口
    def self.post_transfer_query()

    end

    #4.出款批次查询接口
    def self.post_withdraw_query()

    end

  end
end