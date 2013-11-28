class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy]

  # GET /bids
  # GET /bids.json
  def index
    @bids = Bid.all
  end

  # GET /bids/1
  # GET /bids/1.json
  def show
  # @bids = Bid.all(:include => :servicerequest, :conditions => { :servicerequests => {:servicerequest_id =>  request_params.servicerequest_id} }, :order => "bids.bidamt ASC")
  end

  # GET /bids/new
  def new
    @bid = Bid.new
  end

  # GET /bids/1/edit
  def edit
  end

  # POST /bids
  # POST /bids.json
  def create
    @servicerequest = params[:id]
    @bid = Bid.new(bid_params)
    @bid.servicerequest_id = @servicerequest

    respond_to do |format|
       # @bid.servicerequest_id = @servicerequest
	if @bid.save
        format.html { redirect_to @bid, notice: 'Bid was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bid }
      else
        format.html { render action: 'new' }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bids/1
  # PATCH/PUT /bids/1.json
  def update
    respond_to do |format|
      if @bid.update(bid_params)
        format.html { redirect_to @bid, notice: 'Bid was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bids/1
  # DELETE /bids/1.json
  def destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to bids_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
  #    @bid = Bid.where("servicerequest_id =?", params[:id])
  #     @bids = Bid.includes(:servicerequests).where("servicerequests.servicerequest_id =?", params[:id]).references(:servicerequests)
       @bids = Bid.includes(:servicerequests).where(servicerequests: { servicerequest_id: params[:id]})
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      params.permit(:provider_id,:servicerequest_id, :bidamt, :comment, servicerequests_attributes: [:id, :user_id, :provider_id])
    end
end
