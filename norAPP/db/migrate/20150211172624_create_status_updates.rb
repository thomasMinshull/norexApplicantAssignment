class CreateStatusUpdates < ActiveRecord::Migration
  def change
    create_table :status_updates do |t|
    	t.references :users #adds a foriegn key that references the users table
    	t.text "status", :limit => 500 
    	t.timestamps null: false
    end
    #add_index("status_updates","references")
  end
end
