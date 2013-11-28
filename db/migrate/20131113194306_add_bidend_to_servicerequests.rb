class AddBidendToServicerequests < ActiveRecord::Migration
  def change
    add_column :servicerequests, :bidend, :datetime
  end
end
