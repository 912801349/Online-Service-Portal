json.array!(@servicerequests) do |servicerequest|
  json.extract! servicerequest, :appliance, :, :brand, :, :warranty, :
  json.url servicerequest_url(servicerequest, format: :json)
end
