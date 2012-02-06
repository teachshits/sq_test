class MainController < ApplicationController
  
  def index
    @users = User.order('salary DESC')
    @vacancies = Vacancy.order('salary DESC')
  end
  
end
