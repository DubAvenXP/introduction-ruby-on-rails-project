class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.float :value
      t.boolean :status, default: true
      t.references :assignment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
