Rails.application.routes.draw do
  devise_for :users
  
	resources :messages
	get '/messages/:id/reply' => 'messages#reply'
	post '/messages/confirm' => 'messages#confirm'
	
  root 'messages#index'

end
