class CreateAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :assignments do |t|
      t.string :role_assignment
      t.float :amount_to_pay, default: 0.0
      t.boolean :status, default: true
      t.references :user, null: false, foreign_key: true
      t.references :activity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
