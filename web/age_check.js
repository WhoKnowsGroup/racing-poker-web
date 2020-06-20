/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


     
     function display_socialMedia()
     {
         console.log(document.getElementById("age_checkbox").checked);
         if(document.getElementById("age_checkbox").checked)
         {
             $("#social_media").removeClass("disabled");
            // $("#fb-root").removeClass("disabled");
             
         } 
         else
         {
             $("#social_media").addClass("disabled");
         }
            
     }
     
     function display_register()
     {
         if(document.getElementById("age").checked && document.getElementById("terms").checked)
         {
        	 $("#register_form").removeClass("hide");
         }
         else
         {
             $("#register_form").addClass("hide");
         }
     }
