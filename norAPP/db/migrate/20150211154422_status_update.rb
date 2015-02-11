class StatusUpdate < ActiveRecord::Migration
  def change
  	create_table :StatusUpdate do |t|
    	t.references :user_tables #adds a foriegn key that references the user_table
    	t.string "status", :limit => 500
    	t.timestamps
    end
  end
end
