
require 'open-uri'
require 'json'
require 'uri'
require 'mysql2'
require 'rubygems'

class PagesController < ApplicationController

    #Page principale
    def home
    end

    #Retrieve sur l'API
    def result
        
        name        = params[:repo]
        langage     = params[:lang]
        #API github, configurable
        url         = 'https://api.github.com/search/repositories?q='+URI.escape(name)+'+language:'+URI.escape(langage)+'&sort=stars&order=desc'
        
        kittens     = open(url)
     
        @name       = name
        @langage    = langage
        @my_hash    = JSON.parse(kittens.read)
   
    end
    
    #insertion de favori
    def create
       
        #Protection insertion SQL
        name        = Mysql2::Client.escape(params[:name])
        link        = Mysql2::Client.escape(params[:link])
        category    = Mysql2::Client.escape(params[:category])
        id_github   = Mysql2::Client.escape(params[:id])
        
        if Gists.find_by(id_github: params[:id]) != nil
            Gists.find_by(id_github: params[:id]).destroy
        end
        Gists.create name: name, link: link, category: category, id_github: id_github
        head :ok
        
    end
    
    #Affichage des enregistrement
    def index
    
        category    = Mysql2::Client.escape(params[:category])
        if category == "4"
            @gists  = Gists.all
        else
            @gists  = Gists.find_by(category: category)
        end
        
        respond_to do |format|
            format.json {render json: @gists}
        end
    end

    #suppression enregistrement
    def suppr
        
        id          = Mysql2::Client.escape(params[:id])
        Gists.find_by(id_github: id).destroy
        head :ok
        
    end
    
end
