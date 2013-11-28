json.array!(@bids) do |bid|
  json.extract! bid, :bidamt, :servicerequest_id, :provider_id
  json.url bid_url(bid, format: :json)
end
