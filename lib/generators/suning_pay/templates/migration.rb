class CreateSuningPayNotices < ActiveRecord::Migration
  def self.up
    create_table :suning_pay_notices do |t|
      t.text :content
      t.string :sign
      t.string :sign_type, :limit=>30
      t.string :vk_version, :limit=>30
      t.string :deal_flag, :limit=>30
      t.timestamps
    end
  end

  def self.down
    drop_table :suning_pay_notices
  end
end