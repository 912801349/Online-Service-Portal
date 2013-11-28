class AddCommentToBids < ActiveRecord::Migration
  def change
    add_column :bids, :comment, :string
  end
end
