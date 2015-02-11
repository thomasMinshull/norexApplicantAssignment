class CreateStatusUpdates < ActiveRecord::Migration
  def change
    create_table :status_updates do |t|
    	t.references :user_tables #adds a foriegn key that references the user_table
    	t.string "status", :limit => 500
    	t.timestamps null: false
    end
  end
end
