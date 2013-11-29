class Servicerequest < ActiveRecord::Base
   
   validates :appliance, :problem_desc, :service_ctr_location, :service_by, :bidend, :presence => true 

   validate :service_by_greater_than_currentdate, :bidend_greater_than_currentdate, :bidend_less_than_servicebydate
    
	  def service_by_greater_than_currentdate
	    if service_by.present? && service_by < Date.today
	      errors.add(:service_by, " date should not be less than current date.")
	    end
	  end

	  def bidend_greater_than_currentdate
	    if bidend.present? && bidend < Date.today
	      errors.add(:bidend, " date should not be less than current date.")	
	    end
	  end

	  def bidend_less_than_servicebydate
	    if service_by.present? && bidend.present? && bidend > service_by
	      errors.add(:bidend, " date should be less than or equals to Service By Date.")  	
	    end
	  end  
 
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
