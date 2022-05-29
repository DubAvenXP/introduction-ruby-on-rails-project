class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :description
      t.string :activity_type
      t.string :location
      t.float :budget, default: 0
      t.timestamp :start_date
      t.timestamp :end_date
      t.string :access_level, default: 'public'
      t.boolean :enrollment, default: true
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
