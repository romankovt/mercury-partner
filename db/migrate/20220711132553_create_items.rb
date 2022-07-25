# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.bigint :supplier_id
      t.index :supplier_id

      t.timestamps
    end
  end
end
