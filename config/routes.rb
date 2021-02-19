Rails.application.routes.draw do
  root 'static_pages#home'
  #get 'home', to: "static_pages#home" #penso que nao é necessaria por termos a root ja a fazer o mesmo ?!-QA
  get 'help', to: "static_pages#help" 
  get 'about', to: "static_pages#about"
  get 'contacts', to: "static_pages#contact"
  #get 'static_page/login'
  #get 'static_page/signup'
end
