class ChangeDataTypeForUser < ActiveRecord::Migration
  def self.up
    change_table :servicerequests do |t|
       t.change :total_amt_paid, :decimal
    end
  end
  def self.down
    change_table :servicerequests do |t|
       t.change :total_amt_paid, :integer
    end  
  end
end
