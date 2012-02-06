class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string      :name
      t.timestamps
    end
    
    create_table :skills_users, :id => false do |t|
      t.integer     :skill_id
      t.integer     :user_id
    end
    
    create_table :skills_vacancies, :id => false do |t|
      t.integer     :skill_id
      t.integer     :vacancy_id
    end
  end
end
