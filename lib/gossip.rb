require 'csv'
class Gossip
		attr_accessor :author, :content

	def initialize (author, content)
		@author = author
		@content = content		
	end

	def save #Enregistre les gossip dans la db
	  CSV.open("./db/gossip.csv", "ab") do |csv|
    	csv << [@author, @content]
		end
	end

	 def self.all #Range les gossip dans un array
		all_gossips = []		
		CSV.read("./db/gossip.csv").each do |csv_line|
    	all_gossips << Gossip.new(csv_line[0], csv_line[1])
  	end
		return all_gossips
	end

	def self.find(id) #Numérote les gossip, leur donne l'ID, utile pour les URL dynamiques 
    row = CSV.read("./db/gossip.csv")[id.to_i]
    Gossip.new(row[0], row[1])
  end

  def self.update (id, author, content)
    gossips = Gossip.all
    gossips[id.to_i] = Gossip.new(author,content)
    	CSV.open("./db/gossip.csv",'w') do |csv| #w = write only et change le file db actuel (dans le docu sinatra)
      csv =""
    	end
    gossips.each do |gossip|
      gossip.save
    end
  end

end	