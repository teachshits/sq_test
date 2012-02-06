# coding:utf-8
class User < ActiveRecord::Base
  has_and_belongs_to_many :skills, :uniq => true, :order => 'name ASC'
  
  validates_presence_of :name,      :message => 'Введите имя'
  validates_presence_of :salary,    :message => 'Введите зарплату'
  validates_presence_of :contacts,  :message => 'Введите контакты'
  validate :check_name, :if => Proc.new { |u| u.name.presence }
  validate :check_contacts, :if => Proc.new { |u| u.contacts.presence }
  
  def vacancies(full_coincidence = false)
    user_skill_ids = skills.any? ? skills.map(&:id).join(',') : '0'
    Vacancy.find_by_sql("SELECT vacancies.id, vacancies.title, vacancies.salary, COUNT(sv.skill_id) FROM vacancies
                     INNER JOIN skills_vacancies AS sv ON vacancies.id = sv.vacancy_id
                          WHERE (sv.skill_id IN (#{user_skill_ids}))
                            AND DATE(now()) <= DATE(vacancies.expire_date)
                       GROUP BY vacancies.id, vacancies.title, vacancies.salary
                         HAVING COUNT(sv.skill_id) #{full_coincidence ? '=' : '!='} (SELECT COUNT(*) FROM skills_vacancies WHERE skills_vacancies.vacancy_id = vacancies.id)
                       ORDER BY vacancies.salary DESC")
  end
  
  private
  
  def check_name
    errors.add(:base, 'Введите полное имя') unless name.split(' ').size == 3
    errors.add(:base, 'Имя должно состоять из русского текста и пробелов') if name.scan(/([^а-яёъ ]+)/i).any?
  end
  
  def check_contacts
    errors.add(:base, 'Контактная информация должна содержать email либо телефон') if contacts.scan(/([-a-z0-9_.+]+@[-a-z0-9.]+\.[-a-z0-9]{2,8})|([0-9]{10})/i).empty?
  end
  
end
