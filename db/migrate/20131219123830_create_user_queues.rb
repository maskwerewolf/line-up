class CreateUserQueues < ActiveRecord::Migration
  def change
    create_table :user_queues do |t|
      t.string :account_name #账号
      t.integer :in_queue_num, default: 0 #队列号
      t.integer :out_queue_num, default: 0 #发钱号
      t.integer :queue_type
      t.integer :acquisition_amount_count, default: 0 #发钱次数
      t.integer :last_acquisition_amount, default: 0 #最后一次发钱金额
      t.datetime :last_acquisition_time #最后一次发钱时间
      t.integer :acquisition_amount_total, default: 0 #发钱总额
      t.boolean :is_acquisition_amount, default: false
      t.boolean :is_in_queue, default: false #是否可入队列
      t.timestamps
    end
  end
end
