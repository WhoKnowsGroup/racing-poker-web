
var height = 0.0;
var width = 0.0;

     $(document).ready(function()
     {
    
    height = screen.height;
    width = screen.width;
    console.log(height);
    console.log(width);
    if(width < 1024)
    {
        if(width > 900 && width < 1024)
        {
            
        }
        if(width < 900 && width > 600)
        {
            for(var j=1; j < 31 ; j++)
            {
                var card_id = "im"+ j;
                document.getElementById(card_id).src = "/images/pt-card.png";
                var im_id = document.getElementById(card_id);
                   //im_id.style.border = '2px solid #FFFFFF' ;
                   $(im_id).animate({height:'60px'},"fast");
                    $(im_id).animate({width:'35px'},"fast"); 
            }
            
        }
        if(width < 600 && width > 400)
        {
            
        }
        if(width < 400)
        { 
            $("#menu_left").hide();
            $("#menu_right").hide();
            $("#menu_center").addClass("col-xs-10 col-md-10");
            $("#div21").hide();
            for(var j=1; j < 31 ; j++)
            {
                var card_id = "im"+ j;
                document.getElementById(card_id).src = "/images/pt-card.png";
                var im_id = document.getElementById(card_id);
                   //im_id.style.border = '2px solid #FFFFFF' ;
                   $(im_id).animate({height:'35px'},"fast");
                    $(im_id).animate({width:'20px'},"fast"); 
            }
        }
       // alert("Web page would look better if you rotate your device");
       // menu_left.style.fontSize = "12px";
     
    }
});


