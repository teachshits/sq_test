# coding:utf-8
class Skill < ActiveRecord::Base
  
  has_and_belongs_to_many :users
  has_and_belongs_to_many :vacancies
  
  validates_presence_of   :name, :message => 'Введите название'
  validates_uniqueness_of :name, :message => 'Такое умение уже существует', :case_sensitive => false, :if => Proc.new { |s| s.name.presence }
  
end
