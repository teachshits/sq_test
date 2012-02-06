# coding:utf-8
require 'spec_helper'

describe UsersController do
  before(:each) do
    @valid_params = {:name => 'Иванов Иван Иванович', :need_job => true, :salary => 100000, :contacts => 'Мой личный email: vano@ivanovo.ru'}
    @invalid_params = {:name => 'Ivanov Иван_Иванович'}
  end
  
  it 'create new user' do
    expect {
      post :create, :user => @valid_params
      User.last.name.should == @valid_params[:name]
      response.should redirect_to User.last
    }.to change(User, :count).by(1)
    
    expect {
      post :create, :user => @invalid_params
      response.should render_template 'users/new'
    }.to change(User, :count).by(0)
  end

  describe 'something' do
    before(:each) do
      @user = User.create!(@valid_params)
    end
    
    it 'show existed user' do
      get :show, :id => @user.id
      response.should be_success
      response.should render_template 'users/show'
    end

    it 'edit existed user' do
      get :edit, :id => @user.id
      response.should be_success
      response.should render_template 'users/edit'
    end

    it 'update existed user' do
      new_valid_params = {:name => 'Петров Петр Петрович', :need_job => false, :salary => 100, :contacts => 'Мой личный email: petr@ivanovo.ru'}
      put :update, :id => @user.id, :user => new_valid_params
      @user.reload
      @user.name.should == new_valid_params[:name]
      response.should redirect_to @user
    
      put :update, :id => @user.id, :user => @invalid_params
      @user.reload
      @user.name.should == new_valid_params[:name]
      response.should render_template 'users/edit'
    end
  end
end