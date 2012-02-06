SqTest::Application.routes.draw do
  
  root :to => 'main#index'
  
  resources :users do
    resources :skills
  end
  
  resources :vacancies do
    resources :skills
  end
  
end
