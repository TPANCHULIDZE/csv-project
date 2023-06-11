# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root 'drugs#index'

  resources :drugs, except: %i[update edit new]
  get 'drugs/companies/:company', to: 'drugs#companies', as: :companies_drugs
end
