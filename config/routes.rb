Rails.application.routes.draw do
  
  resources :readings, only: %i[create show] do
    member do
      get :count
    end
  end

end
