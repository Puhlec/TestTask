Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'search',to: 'welcome#search', as: 'search'
  get '/pdfs/*a', to: 'welcome#download_pdf', as: 'download'
  get '/zip/pdfs.zip', to: 'welcome#download_zip', as: 'zip'
  end
