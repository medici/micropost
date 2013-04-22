class AddInReplyToMicroblogs < ActiveRecord::Migration
  def change
  	add_column :microblogs, :in_reply_to, :integer, default: nil
  end
end
