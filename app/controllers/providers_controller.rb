class ProvidersController < ApplicationController
  
     before_action :authenticate_provider!, :only => :index

 before_action :set_servicerequest, :only => :show
 
  def index
      @myrequest = Servicerequest.includes(:bids).where("bids.provider_id" => current_provider.id)
      @myrequest3 = Servicerequest.includes(:bids).where("id" => Bid.where(provider_id:current_provider.id).select(:servicerequest_id))
  end
  def show
  end 
 private
    # Use callbacks to share common setup or constraints between actions.
    def set_servicerequest
    end
  def provider_params
  end
end
