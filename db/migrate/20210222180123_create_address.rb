class CreateAddress < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
    
      t.string :address
      t.string :city
      t.string :zip_code
      t.string :country

      t.timestamps
    end

    change_table :users do |t|

    t.references :address

    end

  end
end

