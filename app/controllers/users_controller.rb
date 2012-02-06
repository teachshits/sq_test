# coding:utf-8
class UsersController < ApplicationController

  before_filter :load_user_and_skills, :only => [:edit, :update]
  
  def index # Users list for vacancy
    @vacancy = Vacancy.find(params[:vacancy_id]) if params[:vacancy_id]
    raise ActiveRecord::RecordNotFound unless @vacancy
    @full = @vacancy.users(true)
    @part = @vacancy.users
  end
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    @user.save!
    redirect_to @user, :notice => 'Новый работник добавлен'
  rescue
    flash[:errors] = get_my_errors(@user)
    render 'new'
  end

  def update
    @user.update_attributes!(params[:user])
    redirect_to @user, :notice => 'Работник успешно изменен'
  rescue
    flash[:errors] = get_my_errors(@user)
    render 'edit'
  end
  
  private
  
  def load_user_and_skills
    @user = User.find(params[:id])
    @skills = @user.skills
    @all_skills = Skill.order('name ASC')
  end
  
end