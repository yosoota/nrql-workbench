class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.text :query
      t.text :result
      t.text :javascript_source

      t.timestamps
    end
  end
end
