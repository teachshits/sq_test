require 'spec_helper'

describe Vacancy do
  before(:each) do
    @vacancy = Vacancy.create!(:title => 'Ruby on Rails developer', :salary => '123', :contacts => 'qwe@asd.zxc')
  end
        
  it 'add some skills' do
    skill = Skill.create(:name => 'Ruby on Rails')
    @vacancy.skills << skill
    @vacancy.skills.first.should == skill
  end
end
