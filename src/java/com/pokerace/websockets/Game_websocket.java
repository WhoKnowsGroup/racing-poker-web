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
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import javax.websocket.OnError;
import com.pokerace.websockets.socket_connect;

/**
 *
 * @author lokesh
 */
@ServerEndpoint("/game_websocket")
public class Game_websocket {
    int count=0;
    String msg="";
    Socket socket;
    socket_connect connect;
    
    @OnMessage
    public String onMessage(String message,Session session) {
      try {
          
         System.out.println("Received"+message);
         String[] arr = message.split(",");
      
       if(arr[0].equals("idle"))
       {
           
       }
       else
       {
           if(arr[0].equals("connect"))
           {
           connect = new socket_connect(message,session);
           System.out.println("Connect");
           connect.start();
           }
           if(arr[0].equals("bet:true"))
           {
               connect.send_message_socket(message);
           }
           if(arr[0].equals("Chat:true"))
           {
               System.out.println(arr);
               connect.send_message_socket(message);
           }
       }
         } catch (Exception ex) {
            //ex.printStackTrace();
             System.out.println(ex);
        }
      return null;
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
      
    @OnOpen
    public void onOpen(Session session){
        try
        {
            
        //session.setMaxIdleTimeout(0);
        count++;
        System.out.println(count);
        System.out.println(session.getId() + " has opened a connection"); 
        session.getBasicRemote().sendText("started"); 
       }
       catch(Exception e)
       {
           
          
       }
    }
     public void send_message_client(Session session)
    {
      Boolean check = true;
      try
      {
      while(check)
      {
      BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
       System.out.println(socket.getPort()+","+socket.getLocalAddress());
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
      }
    }
      public void send_message_socket(String   message)
    {
      try
      {
      PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
      msg = message;
      out.println(msg);   
       System.out.println(socket.getPort()+","+socket.getLocalAddress());
      }
      catch(Exception e)
      {
          System.out.println(e);
      }
    }
}
