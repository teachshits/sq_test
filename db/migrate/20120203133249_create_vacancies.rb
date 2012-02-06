class CreateVacancies < ActiveRecord::Migration
  def change
    create_table :vacancies do |t|
      t.string      :title
      t.date        :expire_date
      t.integer     :salary
      t.text        :contacts
      t.timestamps
    end
  end
end
