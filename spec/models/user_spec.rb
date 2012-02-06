# coding:utf-8
require 'spec_helper'

describe User do
  before(:each) do
    @user = User.create!(:name => 'Викторов Виктор Викторович', :salary => '123', :contacts => 'qwe@asd.zxc')
  end
        
  it 'add some skills' do
    skill = Skill.create(:name => 'Ruby on Rails')
    @user.skills << skill
    @user.skills.first.should == skill
  end
end
