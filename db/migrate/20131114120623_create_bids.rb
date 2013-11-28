class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.decimal :bidamt
      t.integer :servicerequest_id
      t.integer :provider_id

      t.timestamps
    end
  end
end
