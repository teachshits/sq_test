require 'spec_helper'

describe VacanciesController do
  before(:each) do
    @valid_params = {:title => 'True vacanvy', :expire_date => Date.today + 1.month, :salary => 100000, :contacts => 'hr@company.com'}
    @invalid_params = {:title => 'Fail vacancy', :salary => nil, :contacts => nil}
  end
  
  it 'create new vacancy' do
    expect {
      post :create, :vacancy => @valid_params
      Vacancy.last.title.should == @valid_params[:title]
      response.should redirect_to Vacancy.last
    }.to change(Vacancy, :count).by(1)
    
    expect {
      post :create, :vacancy => @invalid_params
      response.should render_template 'vacancies/new'
    }.to change(Vacancy, :count).by(0)
  end

  describe 'something' do
    before(:each) do
      @vacancy = Vacancy.create!(@valid_params)
    end
    
    it 'show existed vacancy' do
      get :show, :id => @vacancy.id
      response.should be_success
      response.should render_template 'vacancies/show'
    end

    it 'edit existed vacancy' do
      get :edit, :id => @vacancy.id
      response.should be_success
      response.should render_template 'vacancies/edit'
    end

    it 'update existed vacancy' do
      new_valid_params = {:title => 'Other true vacanvy', :expire_date => Date.today + 1.year, :salary => 10, :contacts => 'hr@company.ru'}
      put :update, :id => @vacancy.id, :vacancy => new_valid_params
      @vacancy.reload
      @vacancy.title.should == new_valid_params[:title]
      response.should redirect_to @vacancy
    
      put :update, :id => @vacancy.id, :vacancy => @invalid_params
      @vacancy.reload
      @vacancy.title.should == new_valid_params[:title]
      response.should render_template 'vacancies/edit'
    end
  end
end
