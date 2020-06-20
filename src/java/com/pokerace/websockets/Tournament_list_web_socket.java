/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pokerace.websockets;

import au.com.suncoastpc.util.CouchDBUtil;
import au.com.suncoastpc.util.types.CouchDatabase;

import com.google.gson.JsonObject;


//import com.pokerace.tournament.Tournament_list;
import java.io.IOException;
import java.util.List;
import java.util.StringTokenizer;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.lightcouch.CouchDbClient;
import org.lightcouch.CouchDbProperties;

/**
 *
 * @author User
 */
@ServerEndpoint("/tournament_list_end_point")
public class Tournament_list_web_socket {
   
    
     
    @OnOpen
    public void onOpen(Session session){
        System.out.println(session.getId() + " has opened a connection"); 
        try {
            session.getBasicRemote().sendText("Connection Established");
            search_tournament_list(session);
        } catch (IOException ex) {
            System.out.println(ex);
        }
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        //System.out.println("message_received");
        
    }
    
      @OnClose
    public void onClose(Session session){
        System.out.println("Session " +session.getId()+" has ended");
    }
    
     public void search_tournament_list(Session session)
    {
        long wait = 4000;
        int count =0;
        int token_count=0;
        while(session.isOpen())
        {
         
        try
        {
         System.out.println("in websocket");
         token_count=0;
         String tournament_active_list =search_active_tournaments();
           StringTokenizer sub_boxes = new StringTokenizer(tournament_active_list);
        
        	while (sub_boxes.hasMoreTokens())
                {
                    String token = sub_boxes.nextToken();
                    token_count++;
                }
         if(count < token_count)       
         {
         session.getBasicRemote().sendText(tournament_active_list);
         count = token_count ;
         }
         Thread.sleep(wait);
        }
        catch(Exception e)
        {
            System.out.println(e);
        }
        }
    }
     protected String search_active_tournaments()
     {
      try
        {
        String tournament_list="";
        CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.ACTIVE_TOURNAMENTS);			//new CouchDbClient(dbProperties);
         List<JsonObject > list = db.view("_all_docs").query(JsonObject.class);
          int count = list.size();
          if(count > 0)
          {
         for(JsonObject json : list)
         {
            // System.out.println(json.toString());
             String token = json.get("id").toString().replace("\"", "");
            // System.out.println(token);
             tournament_list=token+ " " + tournament_list;
             
         }
         
         //aroth:  this should be unnecessary and is probably not correct
         //CouchDBUtil.shutdownClient(CouchDatabase.ACTIVE_TOURNAMENTS);
         //db.shutdown();         
         return tournament_list;
          }
        }
        catch(Exception e)
        {
            System.out.println(e);
            return "fail";
        }
        return null;
     }
}
