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

import au.com.suncoastpc.auth.util.StringUtilities;
import au.com.suncoastpc.conf.Configuration;

/**
 *
 * @author lokesh
 */
public class socket_connect extends Thread {
	String msg;
	Session session1;
	Socket socket;

	socket_connect(String message, Session session) {
		this.msg = message;
		this.session1 = session;
	}

	public void send_message_client(Session session) {
		Boolean check = true;
		try {
			BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
			while (check) {
				System.out.println(" reader");
				msg = reader.readLine();
				System.out.println(msg);
				if (StringUtilities.isEmpty(msg) || msg.equals("close"))
					check = false;
				else
					session.getBasicRemote().sendText(msg);
			}
		}
		catch (Exception e) {
			System.out.println(e);
			try {
				this.session1.getBasicRemote().sendText("Socket:closed");
			}
			catch (Exception e1) {
				System.out.println(e);
			}
		}
	}

	public void send_message_socket(String message) {
		try {
			PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
			msg = message;
			System.out.println(msg);
			out.println(msg);
		}
		catch (Exception e) {
			System.out.println(e);
			try {
				this.session1.getBasicRemote().sendText("Socket:closed");
			}
			catch (Exception e1) {
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
	public void onClose(Session session) {
		System.out.println("Session " + session.getId() + " has ended");
	}

	@Override
	public void run() {
		try {
			if (socket == null)
				socket = new Socket(Configuration.getWebsocketGameplayHost(), Configuration.getWebsocketGameplayPort());
			send_message_socket(this.msg);
			send_message_client(this.session1);
		}
		catch (Exception e) {
			System.out.println(e + "" + Configuration.getWebsocketGameplayPort());
			try {
				this.session1.getBasicRemote().sendText("Socket:closed");
			}
			catch (Exception e1) {
				System.out.println(e);
			}
		}
	}

}
