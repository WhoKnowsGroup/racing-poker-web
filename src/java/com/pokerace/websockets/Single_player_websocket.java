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
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

/**
 *
 * @author lokesh
 */
@ServerEndpoint("/Single_player_websocket")
public class Single_player_websocket  extends Thread
{
    int count=0;
    String msg="";
    Socket socket;
    Single_player_socket connect;
    
    @OnMessage
    public String onMessage(String message,Session session) {
      try {
           /*count++;
           for(int i =0 ; i<5 ; i++)
           */
          System.out.println("Received"+message);
         String[] arr = message.split(",");
      // if(socket == null )    
     //  socket = new Socket("103.18.108.70",1066); 
      // send_message_socket(message);
       if(arr[0].equals("idle"))
       {
           
       }
       else
       {
      // send_message_socket(message);
       //send_message_client(session);
           if(arr[0].equals("connect"))
           {
           connect = new Single_player_socket(message,session);
           connect.start();
           }
           if(arr[0].equals("deal:true"))
           {
               connect.send_message_socket(message);
           }
           if(arr[0].equals("bet:true"))
           {
                connect.send_message_socket(message);
           }
           if(arr[0].equals("exit:true"))
           {
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
      
}
