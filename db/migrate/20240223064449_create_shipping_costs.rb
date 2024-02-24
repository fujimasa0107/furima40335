class CreateShippingCosts < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_costs do |t|

      t.timestamps
    end
  end
end
