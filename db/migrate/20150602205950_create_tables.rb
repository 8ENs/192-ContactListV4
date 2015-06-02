class CreateTables < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.timestamps
    end

    create_table :phones do |t|
      t.string :phone
      t.string :label
      t.references :contact, index: true
      t.timestamps
    end

  end
end
