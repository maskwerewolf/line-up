class CreateAccessRecords < ActiveRecord::Migration
  def change
    create_table :access_records do |t|
      t.string   :ip
      t.integer  :access_count
      t.integer  :access_total
      t.datetime :record_time
      t.timestamps
    end
    add_index :access_records, :ip, :unique => true
  end
end
