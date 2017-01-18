class CreateEntreprises < ActiveRecord::Migration[5.0]
  def change
    create_table :entreprises do |t|

      t.timestamps
    end
  end
end
