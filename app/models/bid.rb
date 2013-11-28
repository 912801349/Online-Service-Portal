class Bid < ActiveRecord::Base
  belongs_to :servicerequest
  belongs_to :provider

end
