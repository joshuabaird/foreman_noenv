Rails.application.routes.draw do
  match 'new_action', to: 'foreman_noenv/hosts#new_action'
end
