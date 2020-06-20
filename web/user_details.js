function create_tournaments()
             {
                window.location.href = "create_tournaments.html";
             }
function manage_bots()
{
    window.location.href = "create_tournaments.html";
    
}
function manage_registered_users()
{
    window.location.href = "create_tournaments.html";
    
}
function sens_inivitations_emails()
{
    window.location.href = "send_invitations.html";
}
function logout() {
   if(typeof(Storage) !== "undefined" && sessionStorage && sessionStorage.userName) {
	   sessionStorage.clear();
   }
   
   window.location.href = "/r/logout";
}