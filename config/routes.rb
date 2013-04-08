IcisPatientEx::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :patients, only: [:index, :show]
    end
  end
end
