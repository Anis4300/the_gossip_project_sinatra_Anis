require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
 		erb :index, locals: {gossips: Gossip.all}
 	end
 	
 	get '/gossips/new/'	do #Permet à l'utilisateur de taper un gossip.
 		erb :new_gossip
 	end
 	
 	post '/gossips/new/' do #Permet d'enregistrer le gossip tapé dans la db.
  	Gossip.new(params['gossip_author'], params['gossip_content']).save
  	redirect '/'
	end	

	get '/gossips/:id/' do #Pour numéroter les gossips, en partant de 0.
    erb :show, locals: {id: params["id"], gossip: Gossip.find(params["id"])}
	end	

	get '/gossips/:id/edit/' do #.
    erb :edit, locals: {id: params["id"], gossip: Gossip.find(params["id"])}
	end	

	post '/gossips/:id/edit/' do
  	Gossip.update(params['id'],params['gossip_author'], params['gossip_content'])
  	redirect '/'
	end			

  post '/gossips/:id/edit/' do
    Gossip.update(params['id'],params["gossip_author"],params["gossip_content"])
		redirect '/'
  end
end