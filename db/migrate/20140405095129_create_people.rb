class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :lastname
      t.string :firstname
      t.string :email
      t.date :dateofbirth
      t.string :private_phone
      t.string :professional_phone

      t.timestamps
    end
  end
end
