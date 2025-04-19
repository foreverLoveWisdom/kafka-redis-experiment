class CreateTransfers < ActiveRecord::Migration[8.0]
  def change
    create_table :transfers do |t|
      t.string :from
      t.string :to
      t.integer :amount

      t.timestamps
    end
  end
end
