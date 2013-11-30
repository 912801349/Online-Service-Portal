class ServicerequestsController < ApplicationController
  before_action :set_servicerequest, only: [:show, :edit, :update, :destroy]
  # GET /servicerequests
  # GET /servicerequests.json
  def index
    #@servicerequests = Servicerequest.all
   if user_signed_in?
      @servicerequests = Servicerequest.find(:all, :conditions => {:user_id => current_user.id})
   else
      @servicerequests = Servicerequest.find(:all, :conditions => ["status =? AND bidend >=?", 'Open', Date.today ])
   end
  end

# Post provider to servicerequest

  # GET /servicerequests/1
  # GET /servicerequests/1.json
  def show
    if user_signed_in?
      @servicerequests = Servicerequest.find(:all, :conditions => {:user_id => current_user.id})
    else
    #  @servicerequests = Servicerequest.find(:all, :conditions => {:status => 'Open'})
       @servicerequests = Servicerequest.where("status = ? AND bidend >= ?", 'Open', DateTime.now)  
    end

  end

  # GET /servicerequests/new
  def new
    @servicerequest = Servicerequest.new
    1.times { @servicerequest.bids.build}
  end

  # GET /servicerequests/1/edit
  def edit
  end

  # POST /servicerequests
  # POST /servicerequests.json
  def create
    @servicerequest = Servicerequest.new(servicerequest_params)

    respond_to do |format|
      if @servicerequest.save
        format.html { redirect_to @servicerequest, notice: 'Servicerequest was successfully created.' }
        format.json { render action: 'show', status: :created, location: @servicerequest }
      else
        format.html { render action: 'new' }
        format.json { render json: @servicerequest.errors, status: :unprocessable_entity }
      end
    end
  end

# Post provider to servicerequest
  # PATCH/PUT /servicerequests/1
  # PATCH/PUT /servicerequests/1.json
  def update
    respond_to do |format|
      if @servicerequest.update_attributes(servicerequest_params)
        format.html { redirect_to @servicerequest, notice: 'Service Request was successfully updated.' }
        format.json { head :no_content }
        if  @servicerequest.provider_id?
              @provider = Provider.find_by_id(@servicerequest.provider_id) 
               UserMailer.winningbid(@provider,current_user).deliver
               UserMailer.awardbid(@provider,current_user).deliver
               # @servicerequest.bids.each do |p|
	         # unless p.provider_id == @provider.id
                  #   @nonwin = Provider.find_by_id(p.provider_id)
                   #  UserMailer.losingbid(@nonwin, current_user, @servicerequest.appliance).deliver
                 # end
              # end
                 flash.alert = "Email notification already sent to you and to your selected Service Provider as confirmation."
		# flash.notice = "email also sent to you as confirmation"
         end 

      else
        format.html { render action: 'edit' }
        format.json { render json: @servicerequest.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /servicerequests/1
  # DELETE /servicerequests/1.json
  def destroy
    @servicerequest.destroy
    respond_to do |format|
      format.html { redirect_to servicerequests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_servicerequest
      @servicerequest = Servicerequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def servicerequest_params
#       params.permit!
      params.required(:servicerequest).permit(:user_id, :appliance, :brand, :warranty, :problem_desc, :service_ctr_location,:provider_id, :service_by, :status, :bidend, :total_amt_paid, :paid_through, :feedback,bids_attributes: [:id,:comment, :provider_id, :bidamt]) if params[:servicerequest] 
   end
end
