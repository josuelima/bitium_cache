class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :application
      t.string :resource

      t.timestamps
    end
  end
end
