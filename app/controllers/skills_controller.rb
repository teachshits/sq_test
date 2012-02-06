class SkillsController < ApplicationController
  
  before_filter :load_obj
  
  def create
    @skill = Skill.find(params[:skill_id]) if params[:skill_id]
    @skill ||= Skill.create(params[:skill])
    if @skill && !@skill.new_record? && @obj.skills.exclude?(@skill)
      @obj.skills << @skill
    else
      @errors = get_my_errors(@skill)
    end
    @skills = @obj.skills
  end
  
  def destroy
    @skill = Skill.find(params[:id])
    @obj.skills.delete(@skill)
    @skills = @obj.skills
  end

  private
  
  def load_obj
    @obj = User.find(params[:user_id]) if params[:user_id]
    @obj = Vacancy.find(params[:vacancy_id]) if params[:vacancy_id]
    raise ActiveRecord::RecordNotFound unless @obj
  end
  
end
