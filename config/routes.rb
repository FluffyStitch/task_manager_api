Rails.application.routes.draw do
  get '/', to: redirect('/docs.html')

  namespace :api do
    namespace :v1 do
      namespace :auth do
        post '', to: 'registrations#create'
        post '/sign_in', to: 'sessions#create'
        delete '/sign_out', to: 'sessions#destroy'
      end

      resources :projects do
        resources :tasks, shallow: true do
          patch '/complete', to: 'tasks#complete'
          patch '/position', to: 'tasks#position'
          resources :comments, only: %i[index create destroy]
        end
      end
    end
  end
end
