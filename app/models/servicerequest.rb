class Servicerequest < ActiveRecord::Base
   belongs_to :user
   belongs_to :provider
   has_many :bids, :dependent => :destroy
   accepts_nested_attributes_for :bids, :reject_if => lambda { |a| a[:bidamt].blank? }, :allow_destroy => true


def self.closingbid
   curdt = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
   closedbid = Bid.find_by_sql "Select b.servicerequest_id, max(b.provider_id) as winner, min(b.bidamt) as winningbid from bids b , servicerequests s where s.id = b.servicerequest_id and s.status = 'Open' and s.bidend <= '" + curdt + "' group by b.servicerequest_id " 

    closedbid.each do |u|
        service = Servicerequest.find_by_sql "Select s.* from servicerequests s where s.id = " + u.servicerequest_id.to_s
        service.each do |s|
          # puts s.id
          # puts s.user_id
                       # to update the activerecord
           s.provider_id = u.winner
           s.status = 'Closed'
           s.save
          #  puts s.provider_id
          #  puts s.appliance
          #  puts u.servicerequest_id 
          #  puts u.winner
          #  puts u.winningbid
       end
    end

end


end
