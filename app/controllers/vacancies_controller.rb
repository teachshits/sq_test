# coding:utf-8
class VacanciesController < ApplicationController

  before_filter :load_vacancy_and_skills, :only => [:edit, :update]
  
  def index # Vacancies list for user
    @user = User.find(params[:user_id]) if params[:user_id]
    raise ActiveRecord::RecordNotFound unless @user
    @full = @user.vacancies(true)
    @part = @user.vacancies
  end
  
  def new
    @vacancy = Vacancy.new
  end
  
  def show
    @vacancy = Vacancy.find(params[:id])
  end

  def create
    @vacancy = Vacancy.new(params[:vacancy])
    @vacancy.save!
    redirect_to @vacancy, :notice => 'Новая вакансия добавлена'
  rescue
    flash[:errors] = get_my_errors(@vacancy)
    render 'new'
  end

  def update
    @vacancy.update_attributes!(params[:vacancy])
    redirect_to @vacancy, :notice => 'Вакансия успешно изменена'
  rescue
    flash[:errors] = get_my_errors(@vacancy)
    render 'edit'
  end
  
  private
  
  def load_vacancy_and_skills
    @vacancy = Vacancy.find(params[:id])
    @skills = @vacancy.skills
    @all_skills = Skill.order('name ASC')
  end
end
