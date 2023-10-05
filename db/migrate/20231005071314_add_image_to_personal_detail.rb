class AddImageToPersonalDetail < ActiveRecord::Migration[7.0]
  def change
    add_column :personal_details, :image, :string
  end
end
