class CreatePacks < ActiveRecord::Migration
  def change
    create_table :packs do |t|
      t.string :name, null: false
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
