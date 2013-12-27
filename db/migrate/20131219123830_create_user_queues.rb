class CreateUserQueues < ActiveRecord::Migration
  def change
    create_table :user_queues do |t|
      t.string :account_name #账号
      t.integer :in_queue_num, default: 0
      t.integer :out_queue_num, default: 0
      t.integer :idle_queue_num, default: 0
      t.integer :queue_type
      t.integer :acquisition_amount_count, default: 0
      t.integer :last_acquisition_amount, default: 0
      t.datetime :last_acquisition_time
      t.integer :acquisition_amount_total, default: 0 #发钱总额
      t.boolean :is_acquisition_amount, default: false
      t.boolean :is_in_queue, default: false
      t.timestamps
    end
  end
end
