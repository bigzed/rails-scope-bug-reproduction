class CreateChairs < ActiveRecord::Migration[7.0]
  def change
    create_table :chairs do |t|
      t.string :type, null: false
      t.string :color, null: false
      t.references :room

      t.timestamps
    end
  end
end
