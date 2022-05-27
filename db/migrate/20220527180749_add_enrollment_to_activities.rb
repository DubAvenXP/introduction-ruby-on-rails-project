class AddEnrollmentToActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :enrollment, :boolean, default: true
  end
end
