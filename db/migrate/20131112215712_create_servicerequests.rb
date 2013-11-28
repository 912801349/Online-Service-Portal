class CreateServicerequests < ActiveRecord::Migration
  def change
    create_table :servicerequests do |t|
      t.belongs_to :user
      t.belongs_to :provider
      t.string :appliance
      t.string :brand
      t.string :warranty
      t.string :problem_desc
      t.string :service_ctr_location
      t.string :status
      t.string :total_amt_paid
      t.string :paid_through
      t.string :feedback
      t.timestamps
    end
  end
end
