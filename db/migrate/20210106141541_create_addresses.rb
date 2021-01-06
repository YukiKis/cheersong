class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :song, foreign_key: true
      t.text :url, null: false

      t.timestamps
    end
  end
end
