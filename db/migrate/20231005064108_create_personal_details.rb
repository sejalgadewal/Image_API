class CreatePersonalDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :personal_details do |t|
      t.string :mobile
      t.string :email
      t.string :gender
      t.string :dob
      t.string :marital_status
      t.string :blood_group

      t.timestamps
    end
  end
end
