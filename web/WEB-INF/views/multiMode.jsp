<!DOCTYPE html>
<%@ page isELIgnored='false' %>
<%@ taglib tagdir='/WEB-INF/tags' prefix='rp' %>
<html>
    <head>
    <title>Racing Poker Tournament | Online Poker Tournament</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords" content="Poker,racing poker,online poker,poker tournaments,players">
    <meta name="application-name" content="Racing Poker">
    <meta name="author" content="Pokerace Team">
    <meta property="og:image" content="https://www.racingpoker.com/images/racingpoker-logo9.png">     
    <link rel="icon" href="/images/racingpoker-logo9.png" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link href="https://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="/css/maintemplate.css" />
    <link href="/css/bootstrap-switch.css" rel="stylesheet">
  <style>
      @media (min-width:1200px)
      {
          .container{
              max-width : 1024px;
              max-height: 600px;
              
          }
         
      }
     @media (min-width:150px) and (max-width:350px)
     {
         body{
        
         }
        
             
        .responsive > img{
             width:25px;
             height:45px;
            
              }
              .responsive {
                  font-size: 15px;
              }
     }
      @media (min-width:351px) and (max-width:600px)
     {
         body{
  
         }
        
             
        .responsive > img{
             width:32px;
             height:50px;
            
              }
              .responsive {
                  font-size: 15px;
              }
     }
     
             ::-webkit-scrollbar-track
{
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0);
    background-color: #F5F5F5;
}

::-webkit-scrollbar
{
    width: 12px;
    background-color: #F5F5F5;
}

::-webkit-scrollbar-thumb
{
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0);
    background-color: #555;
}     
#nobet_popup {
    position: fixed;
    /*left: auto;*/
    right:40px;
   /* width: 120px;*/
}  
.modal-header
 {
     background:url('/images/tail-row-top.png') repeat;
     
 }
 .modal-footer{
      background:url('/images/tail-cont.png') repeat;
 }
 
 .modal-content {
      color:#ffffff;
      background:url('/images/bg-menu.gif') repeat center 0px;
 }
 .modal {
     .input {
         color:#E77817
     } 
 }
  </style>
    <script type="text/javascript">
	  	window.options = {	loadResponsiveVoice: false, 
			loadFbGuestMode: false, 
			isGuestMode: false,
			audioOn: false,
			helpOn: false,
			isSinglePlayer: false,
			playerName: "${ user.nickname }", 
			username: "${ user.email }",
			tournamentId: "${ tournament }",
			socketHost: window.location.host, 
			socketPath: 'game_websocket'
		};
	</script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src="/Jquery/bootstrap-switch.js"></script>
    <script type="text/javascript" src="/user_details.js" > </script>
    <script type="text/javascript" src="/Gamesocket.js" > </script>
    <script src="/Gamesocket-legacyui.js"></script>
    <script type="text/javascript" src="/Timer_clock.js" > </script>
    </head>
    <body style="background-color:#070707;">
        <div class="container">
            
        <!---Player Profile --->
        <div  class="row navbar-fixed-top" >
            <div class="container" style="background: url('/images/tail-row-top.png');color:white">
            <!---- Player Name ---->
            <div id="current_name"  class="col-sm-2 col-xs-6">
                
            </div>
            <div  id="current_balance"  class="col-sm-2 col-xs-6">
                
            </div>
            <!--- Credits --->
            <div id="current_level" class="col-sm-2 col-xs-6">
                
            </div>
            <!-- Bitlets --->
            <div id="current_bitlets" class="col-sm-2 col-xs-6">
                
            </div>
            <!-- Current position -->
             <div id="current_pos" class="col-sm-1 col-xs-6">
                
            </div>
            <!-- Current profit --->
            <div id="current_last_win" class="col-sm-3 col-xs-6">
                
            </div>
            
           
            </div>
        </div>
        <div class="row">
            <!---Left Menu ---->
            <div id="menu_left" class="col-md-3 col-xs-12">
                
              <br/>
              <img src="/images/racingpoker-logo3.jpg" class="img-responsive" height="100" /> 
              <div class="row">
         <table style="width: 100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="166" align="left" valign="top">
                            <div class="leftPanelbox">
                  
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td align="left" valign="top"><div class="leftHading">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td width="32" align="left" valign="top"> <img src="/images/arrow1.gif" alt="" width="27" height="25" /></td>
                                                        <td align="left" valign="middle">
                                                        <div class="row">
                        <div class="col-lg-12 col-sm-12 col-md-12 col-md-12 col-xs-12" >
                            <p>  <span id="tournament_name">  </span> 
                            </p>
                        </div>
              </div>
                                                        </td> 
                                                                                          
                                                    
                                                    </tr>
                                                   
                                                    
                                                            
                                                </table>
                                            </div></td>
                                            
                                    </tr>
                                    
                                    <tr>
                                                    <td align="left" valign="top"><div class="leftMid" id="tournaments_list">
                                    
            <div class="row">
                   <div class="col-lg-3 col-sm-3 col-md-3 col-md-3 col-xs-3" >
                   <p style="font-size:16px;color: whitesmoke"> Id: </p>
                   </div>
                    <div class="col-lg-5 col-sm-5 col-md-5 col-md-5 col-xs-5" >
                     <p id="tournament_id" style="font-size:16px;color:orangered">  </p>
                     </div>
               </div>
             
              <!-- Game number and Timer -->
               <div class="row"> 
                   <div class="col-lg-3 col-sm-3 col-md-3 col-md-6  col-xs-3" >
                   <p style="font-size:16px;color: whitesmoke"> Game: </p>
                   </div>
                   <div class="col-lg-9 col-sm-9 col-md-9 col-md-6 col-xs-6" >
                      <p id="game_number" style="font-size:16px;color:orangered">  </p>
                   </div>
             
               </div>
              <!--- Timer --->
               <div class="row"> 
                   <div class="col-lg-3 col-sm-3 col-md-3 col-md-6 col-xs-3" >
                   <p style="font-size:16px;color: whitesmoke"> Timer: </p>
                   </div>
                   <div class="col-lg-9 col-sm-9 col-md-9 col-md-6 col-xs-9" >
                    <div class="row">
                    <div class="col-md-3 col-xs-3">
                        <span id="timer" style="font-size:16px;color:orangered;text-align:top;">  </span> </div>
                        <div class="col-md-9 col-xs-9 hidden-xs hidden-sm">
                            <span> &nbsp; &nbsp;</span>   <span> <canvas id="canvas" width="50" height="50" style="text-align:top"></canvas> </span>  </div>
                        <div class="pull-right hidden-lg hidden-md"> <span style="color:#ffffff"> Exit: </span>  <button id="exit" style="color:black" class="hidden-lg hidden-md" onclick="exit()">Exit</button>  </div>
                    </div>
                    </div>
               </div>
           
             </div>
             
                                    
                                
                                       
                                                    </td>
                                                </tr>
                                    
                                </table>
                            </div>
                            </td>
                    </tr>
                  </table>
        
         </div>
              <!---tournament name -->
             
              
              <!--tournament id -->
              
               <!---Current Bets --->
                <div class="row hidden-sm hidden-xs"> <p style="font-size:16px;color: whitesmoke;" > 
         <table style="width: 100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="166" align="left" valign="top">
                            <div class="leftPanelbox">
                  
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td align="left" valign="top"><div class="leftHading">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td width="32" align="left" valign="top"> <img src="/images/arrow1.gif" alt="" width="27" height="25" /></td>
                                                        <td align="left" valign="middle">Current bets </td> 
                                                                                          
                                                    
                                                    </tr>
                                                   
                                                    
                                                            
                                                </table>
                                            </div></td>
                                            
                                    </tr>
                                    
                                    <tr>
                                                    <td align="left" valign="top"><div class="leftMid" id="tournaments_list">
                                     <div class="row"> 
             
             <div class="col-lg-4 col-sm-4 col-md-4 col-xs-4" >
                    <div id="current_hand" style=" color: orangered;font-size: 14px">
                                        Hand
                                     </div>
             </div>
              <div class="col-lg-4 col-sm-4 col-md-4 col-xs-4" >
                    <div id="current_amount" style=" color: orangered;font-size: 14px" >
                                         Amount
                                     </div>
             </div>
              <div class="col-lg-4 col-sm-4 col-md-4 col-xs-4" >
                  <div id="current_return" style=" color: orangered;font-size: 14px">
                                         Return
                                    </div>
             </div>
                                                           
                                                        </div>
                                                    </td>
                                                </tr>
                                    
                                </table>
                            </div>
                            </td>
                    </tr>
                  </table>
</div> <br>
               <!--- Bonus --->
               <div class="row hidden-sm hidden-xs " id="bonus_head">
          <table style="width: 100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="166" align="left" valign="top">
                            <div class="leftPanelbox">
                  
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td align="left" valign="top"><div class="leftHading">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td width="32" align="left" valign="top"> <img src="/images/arrow1.gif" alt="" width="27" height="25" /></td>
                                                        <td align="left" valign="middle">Bonus </td> 
                                                                                          
                                                    
                                                    </tr>
                                                   
                                                    
                                                            
                                                </table>
                                            </div></td>
                                            
                                    </tr>
                                    
                                    <tr>
                                                    <td align="left" valign="top"><div class="leftMid" id="tournaments_list">
                                                            <div class="row">
                                     <div class="col-md-6" id="bonus_previous" style="color:#F8C300"></div>
                                     <div class="col-md-6" id="bonus_add" style="color:#F8C300"> </div> </div>
                                                    </td>
                                                </tr>
                                    
                                </table>
                            </div>
                            </td>
                    </tr>
                  </table>
          </div>
               
          <div class="row hidden-xs hidden-sm">
         <table style="width: 100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="166" align="left" valign="top">
                            <div class="leftPanelbox">
                  
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td align="left" valign="top"><div class="leftHading">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td width="32" align="left" valign="top"> <img src="/images/arrow1.gif" alt="" width="27" height="25" /></td>
                                                        <td align="left" valign="middle">Game controls </td> 
                                                                                          
                                                    
                                                    </tr>
                                                   
                                                    
                                                            
                                                </table>
                                            </div></td>
                                            
                                    </tr>
                                    
                                    <tr>
                                                    <td align="left" valign="top"><div class="leftMid" id="tournaments_list">
                                    
                                                             
             <div class="row">
                  
                  <div id="turn_chat" class="col-md-6 col-xs-6" style="color:white;">
                   Chat: &nbsp; <input type="checkbox" name="chat_checkbox" data-size="mini" checked id="chat_hide"  />    </div>
                  <div class="col-md-6 col-xs-6" style="color:white;">
                     Exit: &nbsp; &nbsp;<input type="checkbox" name="exit_checkbox" data-size="mini" data-on-text="YES" data-off-text="NO" id="exit_hide"  />      
                  </div>
                  
             </div> <br>
             
                                                            <div class="row">
                                                                  <div id="turn_audio" class="col-md-6 col-xs-6" style="color:white;">
                   Audio:  <input type="checkbox" name="audio_mode" id="audio_mode" checked data-size="mini" />    </div>
                  
                   <div id="turn_help" class="col-md-6 col-xs-6" style="color:white;">
                   Help: &nbsp; <input type="checkbox" name="help_mode" id="help_mode" data-size="mini" />    </div>
                  
                  
                                                            </div>
         
             
           
             </div>
             
                                    
                                
                                       
                                                    </td>
                                                </tr>
                                    
                                </table>
                            </div>
                            </td>
                    </tr>
                  </table>
        
         </div>
         
              </div>
            <!--- Game Area ---->
            <div class="col-md-6 col-xs-12">
                <div class="row hidden-sm hidden-xs" id="div21"  style="height: 155px; overflow: hidden;">
              
                 <img src="/images/racetrack3.jpg" class="img-responsive"/>
                 <img id="hodd1" src="/images/0111.gif" style="position: relative;top:-135px;"  /> 
                 <img id="hodd2" src="/images/0222.gif"  style="position: relative;top:-115px;left:-60px;" />
                 <img id="hodd3" src="/images/0333.gif" style="position: relative;top:-95px;left:-118px;"   />
                 <img id="hodd4" src="/images/0444.gif" style="position: relative;top:-75px;left:-176px;"  />
                 <img id="hodd5" src="/images/0555.gif" style="position: relative;top:-55px;left:-236px"  />
                 <img id="hodd6" src="/images/0666.gif" style="position: relative;top:-35px;left:-296px"  /> 
                                
               </div>
                 <div class="row" id="div22">
              
                </div>
                 <div class="row" id="div23" >
                 <a href="#" id="pop_up"  onclick= "open_modal()" data-toggle="modal" style="text-decoration: none" >    
                     <div id="house1" onclick="click_hand(1)" style="border-radius: 12px; border: white 1px solid; background-color:#F8C300 ;" >
                         <div class="row">
                             
                             <div class="col-xs-7 col-md-7 responsive">
                                             &nbsp; 
                                                  
                                                  <img id="im1"  src="/images/pt-card.png"  /> 
                                               
                                                 <img id="im2"   src="/images/pt-card.png"  /> 
                                  
                                                  <img id="im3"  src="/images/pt-card.png"  /> 
                                 
                                                  <img id="im4"  src="/images/pt-card.png" /> 
                                    
                                                 <img id="im5"  src="/images/pt-card.png" /> 
                                                 
                             </div>
                             <div class="col-xs-3 col-md-4">
                                    
                                   <div class="responsive" id="hand1_bet" style="font-size:18px;">
                                        </div>
                                 
                                      <div   id="hand1_type_bet" style="font-size:12px;">
                                           
                                       </div>
                                 <span>  <p id="house11"  class="hidden-xs" style="bottom:0px;font-size:12px;" > Bet:0.0 Return:0.0 </p>
                                 </span> 
                             </div>
                             <div class="col-md-1 col-xs-1" style="color: whitesmoke;font-size: 16px;">
                                 &nbsp;
                                 <span> <p> 1 </p> </span>
                             </div>
                             
                                       
                         </div>
                         <div class="row hidden-sm hidden-md hidden-lg">
                             
                             <div class="col-xs-6" style="">
                                 
                                 
                                 <!--img src="/images/dark.png" class="img-responsive"/-->
                                  <img id="hodd11" src="/images/01_ios.gif"  class="hidden-lg hidden-md" style="position: relative;"  />
                            
                                 
                                 </div>
                             <div class="col-xs-6">
                                 <p id="house111"  class="" style="bottom:0px;font-size:12px;text-align:center"> Bet:0.0 Return:0.0 </p>
                             </div>
                             
                             
                         </div>
                        
                         
                     </div>
                     <div id="house2" onclick="click_hand(2)" style="border-radius: 12px; border: white 1px solid; background-color:#DA251D;margin: 0px" >
                            <div class="row">
                             <div class="col-xs-7 col-md-7 responsive">
                                                &nbsp;
                                                <img id="im6" src="/images/pt-card.png"  /> 
                                               
                                                 <img id="im7"  src="/images/pt-card.png"  /> 
                                  
                                                  <img id="im8"  src="/images/pt-card.png"  /> 
                                 
                                                  <img id="im9"  src="/images/pt-card.png" /> 
                                    
                                                 <img id="im10"  src="/images/pt-card.png" /> 
                             </div>
                             <div class="col-xs-3 col-md-4">
                                  <div class="responsive" id="hand2_bet" style="font-size:18px;">
                                        </div>
                                 
                                      <div  class="" id="hand2_type_bet" style="font-size:12px;">
                                           
                                       </div>
                                 <span>  <p id="house22"  class="hidden-xs" style="bottom:0px;font-size:12px;"> Bet:0.0 Return:0.0 </p>
                                 </span> 
                             </div>
                                <div class="col-xs-1 col-md-1" style="color: whitesmoke;font-size: 16px;">
                                    &nbsp; 
                                 <span> <p> 2 </p> </span>
                                </div>
                            </div>
                            <div class="row hidden-sm hidden-md hidden-lg">
                                <div class="col-xs-6">
                                   <img id="hodd22" src="/images/02_ios.gif"  style="position: relative;" />  
                                </div>
                                <div class="col-xs-6">
                                    <p id="house222"  class="" style="bottom:0px;font-size:12px;text-align: center"> Bet:0.0 Return:0.0 </p>
                                </div>
                            
                             
                         </div>
                     </div>
                     <div id="house3" onclick="click_hand(3)" style="border-radius: 12px; border: white 1px solid; background-color:#00923F;margin: 0px" >
                         <div class="row">   
                         <div class="col-xs-7  col-md-7 responsive">
                                                &nbsp;
                                                <img id="im11" src="/images/pt-card.png"  /> 
                                               
                                                 <img id="im12"  src="/images/pt-card.png"  /> 
                                  
                                                  <img id="im13"  src="/images/pt-card.png"  /> 
                                 
                                                  <img id="im14"  src="/images/pt-card.png" /> 
                                    
                                                 <img id="im15"  src="/images/pt-card.png" /> 
                             </div>
                             <div class="col-xs-3 col-md-4">
                                  <div id="hand3_bet" class="responsive" style="font-size:18px;">
                                        </div>
                                 
                                      <div  class="" id="hand3_type_bet" style="font-size:12px;">
                                           
                                       </div>
                                 <span>  <p id="house33"  class="hidden-xs" style="bottom:0px;font-size:12px;"> Bet:0.0 Return:0.0 </p>
                                 </span> 
                             </div>
                             <div class="col-xs-1 col-md-1" style="color: whitesmoke;font-size: 16px;">
                                 &nbsp;
                                 <span> <p> 3 </p> </span>
                             </div>
                         </div>
                         <div class="row hidden-sm hidden-md hidden-lg">
                             <div class="col-xs-6">
                                  <img id="hodd33" src="/images/03_ios.gif" style="position: relative;"   />
                             </div>
                             <div class="col-xs-6">
                                  <p id="house333"  class="" style="bottom:0px;font-size:12px;text-align: center"> Bet:0.0 Return:0.0 </p>
                             </div>
                            
                
                            
                         </div>
                     </div>
                     <div id="house4" onclick="click_hand(4)" style="border-radius: 12px; border: white 1px solid; background-color:#0093DD;margin: 0px" >
                          <div class="row">
                               <div class="col-xs-7 col-md-7 responsive">
                                                &nbsp;
                                                <img id="im16" src="/images/pt-card.png"  /> 
                                               
                                                 <img id="im17"  src="/images/pt-card.png"  /> 
                                  
                                                  <img id="im18"  src="/images/pt-card.png"  /> 
                                 
                                                  <img id="im19"  src="/images/pt-card.png" /> 
                                    
                                                 <img id="im20"  src="/images/pt-card.png" /> 
                             </div>
                             <div class="col-xs-3 col-md-4">
                                 <div id="hand4_bet" class="responsive" style="font-size:18px;">
                                        </div>
                                 
                                      <div  class="" id="hand4_type_bet" style="font-size:12px;">
                                           
                                       </div>
                                 <span>  <p id="house44"  class="hidden-xs" style="bottom:0px;font-size:12px;"> Bet:0.0 Return:0.0 </p>
                                 </span> 
                             </div>
                             <div class="col-xs-1 col-md-1" style="color: whitesmoke;font-size: 16px;">
                                 &nbsp;
                                 <span> <p> 4 </p> </span>
                             </div>
                             
                          </div>
                          <div class="row hidden-sm hidden-md hidden-lg">
                              <div class="col-xs-6">
                                  <img id="hodd44" src="/images/04_ios.gif" style="position: relative;"  />
                              </div>
                              <div class="col-xs-6">
                                   <p id="house444"  class="" style="bottom:0px;font-size:12px;text-align: center"> Bet:0.0 Return:0.0 </p>
                              </div>
                               
                
                            
                         </div>
                     </div>
                     <div id="house5" onclick="click_hand(5)" style="border-radius: 12px; border: white 1px solid; background-color:#6F448A;margin: 0px" >
                         <div class="row">    
                         <div class="col-xs-7 col-md-7 responsive">
                                                &nbsp;
                                                <img id="im21" src="/images/pt-card.png"  /> 
                                               
                                                 <img id="im22"  src="/images/pt-card.png"  /> 
                                  
                                                  <img id="im23"  src="/images/pt-card.png"  /> 
                                 
                                                  <img id="im24"  src="/images/pt-card.png" /> 
                                    
                                                 <img id="im25"  src="/images/pt-card.png" /> 
                             </div>
                             <div class="col-xs-3 col-md-4">
                                 <div id="hand5_bet" class="responsive" style="font-size:18px;">
                                        </div>
                                 
                                      <div  class="" id="hand5_type_bet" style="font-size:12px;">
                                           
                                       </div>
                                 <span>  <p id="house55"  class="hidden-xs" style="bottom:0px;font-size:12px;"> Bet:0.0 Return:0.0 </p>
                                 </span> 
                             </div>
                             <div class="col-xs-1 col-md-1" style="color: whitesmoke;font-size: 16px;">
                                 &nbsp; 
                                 <span> <p> 5 </p> </span>
                             </div>
                             
                         </div>
                         <div class="row hidden-sm hidden-md hidden-lg">
                             
                             <div class="col-xs-6">
                                  <img id="hodd55" src="/images/05_ios.gif" style="position: relative;"  />
                             </div>
                             <div class="col-xs-6">
                                 <p id="house555"  class="" style="bottom:0px;font-size:12px;text-align: center"> Bet:0.0 Return:0.0 </p>
                             </div>
                             
                
                             
                         </div>
                     </div>
                     <div id="house6" onclick="click_hand(6)" style="border-radius: 12px; border: white 1px solid; background-color:#E77817;margin: 0px" >
                         <div class="row">  
                         <div class="col-xs-7 col-md-7 responsive">
                                                &nbsp;
                                                <img id="im26" src="/images/pt-card.png"  /> 
                                               
                                                 <img id="im27"  src="/images/pt-card.png"  /> 
                                  
                                                  <img id="im28"  src="/images/pt-card.png"  /> 
                                 
                                                  <img id="im29"  src="/images/pt-card.png" /> 
                                    
                                                 <img id="im30"  src="/images/pt-card.png" /> 
                             </div>
                             <div class="col-xs-3 col-md-4">
                                 <div id="hand6_bet" class="responsive" style="font-size:18px;">
                                        </div>
                                 
                                      <div  class="" id="hand6_type_bet" style="font-size:12px;">
                                           
                                       </div>
                                 <span>  <p id="house66"  class="hidden-xs" style="bottom:0px;font-size:12px;"> Bet:0.0 Return:0.0 </p>
                                 </span> 
                             </div>
                             <div class="col-xs-1 col-md-1" style="color: whitesmoke;font-size: 16px;">
                                 &nbsp; 
                                 <span> <p> 6 </p> </span>
                             </div>
                                  
                     </div>
                     <div class="row hidden-sm hidden-md hidden-lg">
                         <div class="col-xs-6">
                             <img id="hodd66" src="/images/06_ios.gif" style="position: relative;"  /> 
                         </div>
                            <div class="col-xs-6">
                             <p id="house666"  class="" style="bottom:0px;font-size:12px;text-align: center"> Bet:0.0 Return:0.0 </p>
                         </div>
                              
                             
                         </div>
                     </div>
                 </a>
                 </div>
            </div>
            
            <!-- Right Menu --->
            <div class="col-md-3 col-xs-12">
                 <div class="row">
                <div id="div32">
                    <table style="width: 100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="166" align="left" valign="top">
                            <div class="leftPanelbox">
                  
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td align="left" valign="top"><div class="leftHading">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td width="32" align="left" valign="top"> <img src="/images/arrow1.gif" alt="" width="27" height="25" /></td>
                                                        <td align="left" valign="middle">Connected Players </td> 
                                                                                          
                                                    
                                                    </tr>
                                                   
                                                    
                                                            
                                                </table>
                                            </div></td>
                                            
                                    </tr>
                                    
                                    <tr>
                                                    <td align="left" valign="top"><div class="leftMid" id="tournaments_list">
                                     <div class="row">
                                     <div id="player_name" class="col-sm-6 col-md-6 col-xs-6">
                                         Player Name 
                                     </div>
                                         
                                     <div id="Balance" class="col-sm-6 col-md-6 col-xs-6" >
                                         Balance
                                     </div> 
                                    
                                    
                                                           
                                                        </div>
                                                    </td>
                                                </tr>
                                    
                                </table>
                            </div>
                            </td>
                    </tr>
                  </table>
                    </div>
                    </div>
                <div class="row">
                <div id="div34">
                    <table style="width: 100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="166" align="left" valign="top">
                            <div class="leftPanelbox">
                  
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td align="left" valign="top"><div class="leftHading">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td width="32" align="left" valign="top"> <img src="/images/arrow1.gif" alt="" width="27" height="25" /></td>
                                                        <td align="left" valign="middle">Chat Messages </td> 
                                                                                          
                                                    
                                                    </tr>
                                                   
                                                    
                                                            
                                                </table>
                                            </div></td>
                                            
                                    </tr>
                                    
                                    <tr>
                                                    <td align="left" valign="top">
                                                        <div class="leftMid" >
                                     <div class="row">
                                    
                                      <div id="chat_window1" class="dialogContent" style="" >
            <div id="chat_body2" class="content" style="overflow-y:scroll;height:50px;color:#ffffff;">
                <div id="chat_body3" class="clearfix3"  >
                  
                  <span style="color: green; font-size: 14px">   Admin  </span>  <span> &nbsp; &nbsp; </span> <span class="text-cross"> Welcome to Racing Poker </span>
               
                
                 </div>
               
            </div>
            
            <div id="chat_footer" class="footer">
             <br/>
             <select id="chat_message1" style="width:190px;color:#000000">
             <option>Ouch that hurt</option>    
             <option>A good Choice by me I hope </option>
             <option>Go Go Go you good thing </option>
             <option>This next one will bury me </option>
             <option>Some familiar faces here </option>
             <option>I am taking you all out - for dinner</option>
             <option>Laugh out loud Big Time </option>
             <option>Slammed hard</option>
             <option>Forget me not</option>
             <option>Vicious Deal</option>
             <option>Kiss My Entire Ass</option>
             <option>Leader Board Me Baby</option>
             <option>Shonky result there</option>
             <option>Back on the boil</option>
             <option>is nervous</option>
             <option>is happy</option>
             <option>is really happy</option>
             <option>is optimistic</option>
              <option>feels confident </option>
              <option>yells wow </option> 
              <option>are you kidding!</option>
              <option>breaks into dance</option>

             <option>is wondering what will happen</option>

              <option>screams</option>

               <option>tells a joke</option>
               <option>is calm</option>
               <option>looks worried</option>
                <option>salutes with respect </option>
                 <option>takes a bow</option>
                 <option>is sporting a smirk </option>
             </select>    
             <span class="">
             <button class="btn btn-default btn-md" id="btn-chat" onclick="send_chat1()">
                 Send</button>  </span>          
           </div>
    </div> 
                                                           
                                                        </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                    
                                </table>
                            </div>
                            </td>
                    </tr>
                  </table>
                    </div>
                    </div>
                
                <div class="row">
                    <div id="div33" class="div33 leftPanelbox">
                       <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td align="left" valign="top"><div class="leftHading">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td width="32" align="left" valign="top"> <img src="/images/arrow1.gif" alt="" width="27" height="25" /></td>
                                                        <td align="left" valign="middle">Previous Game Results </td> 
                                                                                          
                                                    
                                                    </tr>
                                                   
                                                    
                                                            
                                                </table>
                                            </div></td>
                                            
                                    </tr>
                                    <tr>
                                        <td class="leftMid">
                                            <table id="result_table" class="leftMid result_tables" >
                                                  <tr>
                                                        <td>
                                                 <div id="game_number">Game &nbsp;</div>
                                                       </td>
                      <td >
                          <div id="Won_hand">
                             Hand &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          </div>
                          
                      </td>
                      <td>
                          <div id="total_bets">
                              Bets &nbsp;
                          </div>
                      </td>
                         <td>
                          <div id="returns">
                               Returns
                          </div>
                      </td>
                  </tr>    

                  
              </table>
                                        </td>
                                    </tr>
                                    
                       </table>
                        
                    </div>
                </div>
                 </div>
            </div>
            <div class="modal fade" id="bonus_popup" tabindex="-1" role="dialog" aria-labelledby="bonus_popup" aria-hidden="true">
    <div class="modal-sm modal-dialog" style="background:#070D0D" >
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h4 class="modal-title" id="myModalLabel" style="color:#E77817"> Bonus </h4>
            </div>
            <div class="modal-body" id="bonus_main" style="color:#E77817;font-size:18;text-align:center">  
                <div class="row">
                <div id="bonus_body" style="text-align:center" >
                    
                </div>
                </div>
            </div>
             <div class="modal-footer">
                <div class="row">
                <button type="button" class="btn btn-primary" data-dismiss="modal" > close </button>  </div>
        </div>
    </div>
  </div>
</div>
      <div class="modal fade" id="loading_popup" tabindex="-1" data-backdrop="static" data-keyboard="false" role="dialog" aria-labelledby="bonus_popup" aria-hidden="true">
    <div class="modal-sm modal-dialog" >
        <div class="modal-content">
            <div class="modal-header">
            </div>
            <div class="modal-body"  style="color:#E77817;">  
                <div class="row">
                <div id="bonus_body" style="" >
                    <p>   <span><img src="/images/grey_loading.gif" width="20" height="20" /> </span>
                        <span> Waiting for other players to connect. </span> </p>
                </div>
                </div>
            </div>
             <div class="modal-footer">
              
        </div>
    </div>
  </div>
</div>
            <div class="modal" id="nobet_popup" tabindex="-1" role="dialog" aria-labelledby="nobet_popup" aria-hidden="true">
    <div class="modal-sm modal-dialog" >
        <div class="modal-content">
            <div class="modal-header">
            </div>
            <div class="modal-body"  style="color:#E77817;">  
                <div class="row">
                <div id="nobet_body" style="" >
                    <p>  Try to place bets in every game.Else you are not allowed bet in the last game</p>
                </div>
                </div>
            </div>
             <div class="modal-footer">
              
        </div>
    </div>
  </div>
</div>
      <div class="modal fade" id="finish_popup" tabindex="-1"  role="dialog" aria-labelledby="bonus_popup" aria-hidden="true">
    <div class="modal-md modal-dialog" >
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h4 class="modal-title" id="myModalLabel" style="color:#E77817"> Results </h4>
            </div>
            <div class="modal-body" id="bonus_main" style="color:#E77817;font-size:18;text-align:center">  
                <div class="row">
                <div id="bonus_body" style="text-align:left" >
                    <div id="animation_image">
                        <img  src="/images/finish_animation.gif"   class="img-responsive"  />
                    </div>
                    <div id="data_info" style="background-image: url('/images/stars-1.GIF')">
                        <div class="row">
                            <div id="id_info" class="col-md-5 col-xs-5 col-sm-5"  >
                               <img  src="/images/win.png"   class="img-responsive" />
                            </div>
                            <div id="player_info" class="col-md-7 col-xs-7 col-sm-7">
                                <div id="finish_rank">
                                    
                                </div>
                                <br/>
                                <div id="current_credits" >
                                    
                                </div>
                                <div id="bonus_credits" >
                                    
                                </div>
                                <div id="total_credits" >
                                    
                                </div>
                                <br/>
                                <div id="finish_level" >
                                    
                                </div>
                                
                                <div id="finish_bitlets" >
                                    
                                </div>
                                <br/>
                                <div id="full_results">
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
            </div>
             <div class="modal-footer">
                <div class="row">
                <button type="button" class="btn btn-primary" data-dismiss="modal" > close </button>  </div>
        </div>
    </div>
  </div>
</div>
      
     <div class="modal fade" id="bets_popup" tabindex="-1" role="dialog" aria-labelledby="bets_popup" aria-hidden="true">
    <div class="modal-sm modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h4 class="modal-title" id="myModalLabel">Bet Slip</h4>
            <div id="Error" style="visibility: hidden;display:none">
                        <p> Not enough Balance </p> 
                    </div>
            </div>
            <div class="modal-body">    
                <div class="row" id="hand_bet_amount">
                    &nbsp;&nbsp;&nbsp;
                <label for="hand"> Hand </label>
                <input id="hand" name="hand" style="color:#E77817" type="text" size="2" maxlength="02" disabled /> 
                    
                <label for="bet_amount"> Bet Amount </label>
                <input id="bet_amount" name="bet_amount" style="color:#E77817"  type="text" size="6"  /> 
                 <br/> 
                 <div style="text-align: center;font-size: 12px;">
                <br/>
                <label for="return_amount"> Return Amount </label>
                <input id="return_amount" name="return_amount" style="color:#E77817" type="text" size="8" disabled /> </div>
                
                </div>
                <div class="row"> <br/> </div>
                <div id="loading_bet" class="row"></div>
                <div class="row  " id="bets_buttons1">
                     &nbsp; &nbsp;
                    <div class="btn-group">
                     <button id="1" onclick="calculate(1)"  class="btn btn-lg btn-primary" > 1 </button>
                     <button id="5" onclick="calculate(5)"  class="btn btn-lg btn-primary" > 5</button>
                     <button id="10" onclick="calculate(10)" class="btn btn-lg btn-primary" >10 </button>
                     <button id="25" onclick="calculate(50)" class="btn btn-lg btn-primary" > 50 </button>                
                     <button id="100" onclick="calculate(100)" class="btn btn-lg btn-primary" > 100 </button>
                     </div>
                   </div>
                
                <div class="row" id="bets_buttons2">
                     &nbsp; &nbsp;      
                     <div class="btn-group">
                     <button id="250" onclick="calculate(250)" class="btn btn-lg btn-primary" > 250 </button>
                     <button id="500" onclick="calculate(500)" class="btn btn-lg btn-primary" > 500 </button>
                     <button id="750" onclick="calculate(750)" class="btn btn-lg btn-primary" > 750 </button>
                     <button id="1000" onclick="calculate(1000)" class="btn btn-lg btn-primary" > 1000 </button>
                     </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row pull-left">
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                <button type="button" onclick="confirm_bet()" id="place_bet" class="btn btn-success"  >Place Bet</button>
                <button type="button" onclick="erase()" id="erase" class="btn btn-danger" > Erase </button>  </div>
        </div>
    </div>
  </div>
</div>
  <!----- Achievements ----->
    <div class="modal fade" id="achievements" tabindex="-1" role="dialog" aria-labelledby="bonus_popup" aria-hidden="true">
    <div class="modal-sm modal-dialog" >
        <div class="modal-content">
            <div class="modal-header">
                <p> <span> <img src="/images/win.jpg" /> Achievements </span>
            </div>
            <div class="modal-body"  style="color:#E77817;">  
                <div class="row">
                <div id="achievements_body" style="">
                    
                </div>
                </div>
            </div>
             <div class="modal-footer">
              
        </div>
    </div>
  </div>
</div>
  
 <!---Winners of Tournament --->
    <div class="modal fade" id="winners_popup" tabindex="-1" role="dialog" aria-labelledby="winners_popup" aria-hidden="true">
    <div class="modal-md modal-dialog" >
        <div class="modal-content">
            <div class="modal-header">
                <p> <span> <img src="/images/win.jpg" /> Tournament results</span>
            </div>
            <div class="modal-body"  style="color:#E77817;">  
                <div class="row">
                <div id="winners_popup_body" style="">
                    
                </div>
                </div>
            </div>
             <div class="modal-footer">
              
        </div>
    </div>
  </div>
</div>
            
            
            </div>
           
    </body>
    <!--script type="text/javascript" src="/talk_voice.js"> </script-->
    <!--cript type="text/javascript" src="/Jquery/responsivevoice.js"> </script-->
</html>
