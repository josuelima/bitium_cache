class CreateUserApplications < ActiveRecord::Migration
  def change
    create_table :user_applications do |t|
      t.integer :user_id
      t.integer :app_id

      t.timestamps
    end
  end
end
