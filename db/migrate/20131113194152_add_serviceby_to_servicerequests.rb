class AddServicebyToServicerequests < ActiveRecord::Migration
  def change
    add_column :servicerequests, :service_by, :datetime
  end
end
