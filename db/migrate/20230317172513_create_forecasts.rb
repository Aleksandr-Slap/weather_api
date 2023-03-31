# frozen_string_literal: true

class CreateForecasts < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    create_table :forecasts do |t|
      t.float :max, null: false
      t.float :min, null: false
      t.float :avg, null: false
      t.hstore :history, array: true, default: [], null: false

      t.timestamps
    end
  end
end
