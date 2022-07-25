# frozen_string_literal: true

class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.bigint :item_id
      t.integer :price
      t.string :status, default: "current"

      t.index :status
      t.index %i[item_id status]
      t.index %i[item_id status], unique: true, where: "(status = 'current')",
        name: "unique_active_index_prices_on_item_id_and_status"

      t.timestamps
    end
  end
end
