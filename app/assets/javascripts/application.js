// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree 


// visuel formulaire enregistrement
function form (id) {
    
    $('.resultat').css('display','none');
    $('#'+id+'').css('display','block');
       
}

function ferm (id) {
    
    $('#'+id+'').css('display','none');
       
}

// affichage des favori page home par ajax
function aff (obj) {
    
    par = $(obj).parent('form').serialize();
    
    $.ajax({
        url : "index", 
        type : "GET",
        data : par,
        dataType: "JSON",
        success : function (text) {
            
            $("#result").children('p').remove();
            if(typeof(text["id"]) == 'undefined') {
                $.each(text, function (key, value) {
                
                    $('<p><a href="'+value["link"]+'" target="_blank">'+value["name"]+'</a><button onClick="suppr(this, '+value["id_github"]+');">supprimer</button></p>').appendTo("#result");
                
                });
            } else {
        
                $('<p><a href="'+text["link"]+'" target="_blank">'+text["name"]+'</a><button onClick="suppr(this, '+text["id_github"]+');">supprimer</button></p>').appendTo("#result");
            }
            
        }
    });
}

//suppression enregistrement page home par $.post
function suppr (obj, id) {
    
    $.post('suppr', {id : id} ).done(function () {
        
        $(obj).parent('p').remove();
        
    });
    
}

