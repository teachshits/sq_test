# coding:utf-8
class Vacancy < ActiveRecord::Base
  has_and_belongs_to_many :skills, :uniq => true, :order => 'name ASC'
  
  validates_presence_of :title,     :message => 'Введите название'
  validates_presence_of :salary,    :message => 'Введите зарплату'
  validates_presence_of :contacts,  :message => 'Введите контакты'
  validate :check_contacts, :if => Proc.new { |v| v.contacts.presence }
  
  def users(full_coincidence = false)
    vacancy_skill_ids = skills.any? ? skills.map(&:id).join(',') : '0'
    User.find_by_sql("SELECT users.id, users.name, users.salary, COUNT(su.skill_id) FROM users
                  INNER JOIN skills_users AS su ON users.id = su.user_id
                       WHERE (su.skill_id IN (#{vacancy_skill_ids}))
                         AND users.need_job IS true
                    GROUP BY users.id, users.name, users.salary
                      HAVING COUNT(su.skill_id) #{full_coincidence ? '=' : '!='} #{skills.count}
                    ORDER BY users.salary ASC")
  end
  
  private
  
  def check_contacts
    errors.add(:base, 'Контактная информация должна содержать email либо телефон') if contacts.scan(/([-a-z0-9_.+]+@[-a-z0-9.]+\.[-a-z0-9]{2,8})|([0-9]{10})/i).empty?
  end
  
end
