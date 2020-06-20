/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pokerace.websockets;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.Session;
import javax.websocket.OnMessage;

import au.com.suncoastpc.conf.Configuration;

/**
 *
 * @author lokesh
 */
public class Single_player_socket extends Thread {
    
    
     String msg ;
    Session session1;
    Socket socket ;
    Single_player_socket(String message , Session session)
    {
        this.msg = message ;
        this.session1 = session ;
    }
     public void send_message_client(Session session)
    {
      Boolean check = true;
      try
      {
          BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
      while(check)
      {
      
      System.out.println(" reader");
      msg = reader.readLine();
      System.out.println(msg);
      if(msg.equals("close"))
      check=false;
      else
      session.getBasicRemote().sendText(msg); 
      }
      }
      catch(Exception e)
      {
          System.out.println(e);
           try
              {
              this.session1.getBasicRemote().sendText("Socket:closed"); 
              }
              catch(Exception e1)
              {
                  System.out.println(e);
              }
      }
    }
      public void send_message_socket(String   message)
    {
      try
      {
      PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
      msg = message;
      System.out.println(msg);
      out.println(msg);   
      }
      catch(Exception e)
      {
          System.out.println(e);
           try
              {
              this.session1.getBasicRemote().sendText("Socket:closed"); 
              }
              catch(Exception e1)
              {
                  System.out.println(e);
              }
      }
    }
       @OnError
    public void onError(Session session, Throwable t) {
        t.printStackTrace();
        System.out.println(t);
    }
     @OnClose
    public void onClose(Session session){
        System.out.println("Session " +session.getId()+" has ended");
    }
     @OnMessage
    public String onMessage(String message,Session session) {
      try {
           System.out.println(message + " Session2");
          }
      catch(Exception e)
      {
          
      }
      return null;
    }
     @Override
      public void run()
      {
          try
          {
               if(socket == null )    
               socket = new Socket(Configuration.getWebsocketGameplayHost(), Configuration.getWebsocketGameplayPort()); 
      // Thread a = new Thread();
      // Thread b = new Thread();
         System.out.println("Message"+this.msg);
         System.out.println(this.session1);
         send_message_socket(this.msg);
         send_message_client(this.session1);
          }
          catch(Exception e)
          {
              System.out.println(e);
              try
              {
              this.session1.getBasicRemote().sendText("Socket:closed"); 
              }
              catch(Exception e1)
              {
                  System.out.println(e);
              }
          }
      }
}
