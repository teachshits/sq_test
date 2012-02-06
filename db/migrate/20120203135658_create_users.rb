class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string        :name
      t.text          :contacts
      t.boolean       :need_job
      t.integer       :salary
      t.timestamps
    end
  end
end
