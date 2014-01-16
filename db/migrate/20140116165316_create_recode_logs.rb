class CreateRecodeLogs < ActiveRecord::Migration
  def change
    create_table :recode_logs do |t|
      t.string  :create_by
      t.string  :account_name #账号
      t.integer :last_acquisition_amount, default: 0
      t.integer :amount
      t.timestamps
    end
  end
end
