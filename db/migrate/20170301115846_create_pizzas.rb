class CreatePizzas < ActiveRecord::Migration[5.0]
  def change
    create_table :pizzas do |t|
      t.string :name
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
