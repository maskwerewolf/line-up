#encoding:utf-8
class AccessRecord < ActiveRecord::Base
  EVERY_HOURS_COUNT = 2
  INTERVAL_TIMES = 3600
  class << self

    def auth_access_record(ip)
      access_record =self.where(ip: ip).first
      if access_record.nil?
        access_record =AccessRecord.new
        access_record.ip = ip
        access_record.access_count = 1
        access_record.access_total = 1
        access_record.record_time = Time.now.localtime
        access_record.save!
      else
        if access_record.access_count < EVERY_HOURS_COUNT
          access_record.access_count = access_record.access_count + 1
          access_record.access_total = access_record.access_total + 1
          access_record.save!
        elsif access_record.access_count >= EVERY_HOURS_COUNT
          interval = (Time.now.localtime.to_i - access_record.record_time.localtime.to_i)
          raise QueueError::FrequentlyAccess if  interval < INTERVAL_TIMES
          if interval > INTERVAL_TIMES
            access_record.record_time = Time.now
            access_record.access_count = 1
            access_record.access_total = access_record.access_total + 1
            access_record.save!
          end
        end
      end
    end
  end
end