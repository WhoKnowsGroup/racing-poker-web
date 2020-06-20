package com.pokerace.filter;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.lightcouch.CouchDbClient;

import au.com.suncoastpc.auth.spring.base.BaseSpringController;
import au.com.suncoastpc.auth.util.StringUtilities;
import au.com.suncoastpc.util.CouchDBUtil;
import au.com.suncoastpc.util.types.CouchDatabase;

import com.google.gson.JsonObject;
import com.maxmind.geoip2.DatabaseReader;
import com.maxmind.geoip2.model.CountryResponse;
import com.maxmind.geoip2.record.Country;

/**
 *
 * @author lokesh
 */
public class IPAddressFilter implements Filter {
	private static final Logger LOG = LogManager.getLogger(IPAddressFilter.class);
	public static final String UNKNOWN_COUNTRY = "zz_BANNED";
	private static final String BANNED_SUFFIX = "_BANNED";

	private static final String SESSION_COUNTRY_KEY = "pokerace.user.country";

	private static DatabaseReader reader = null;
	static {
		try {
			File database = new File(BaseSpringController.getWebappBasePath() + "WEB-INF/geoip/GeoLite2-Country.mmdb");
			reader = new DatabaseReader.Builder(database).build();
		} catch (Throwable ignored) {
		}
	}

	public IPAddressFilter() {
	}
	
	/**
	 *
	 * @param request
	 *            The servlet request we are processing
	 * @param response
	 *            The servlet response we are creating
	 * @param chain
	 *            The filter chain we are processing
	 *
	 * @exception IOException
	 *                if an input/output error occurs
	 * @exception ServletException
	 *                if a servlet error occurs
	 */
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		try {
			doBeforeProcessing((HttpServletRequest)request, (HttpServletResponse)response);
		} catch (Exception ex) {
			LOG.error("Exception in IPAddressFilter!", ex);
		}

		chain.doFilter(request, response);
	}

	/**
	 * Destroy method for this filter
	 */
	@Override
	public void destroy() {
		//no work required
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		//no work required
	}

	private void doBeforeProcessing(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, Exception {
		String country = (String)request.getSession().getAttribute(SESSION_COUNTRY_KEY);
		if (StringUtilities.isEmpty(country)) {
			//attempt to determine country based upon IP address
			DatabaseReader database = getReader();
			String clientIpAddress = getEndpointAddress(request);
			
			try {
				CountryResponse countryResponse = database.country(InetAddress.getByName(clientIpAddress));
				Country countryObj = countryResponse.getCountry();
				country = countryObj.getIsoCode().toLowerCase();
			}
			catch (Exception e) {
				LOG.error("Failed to lookup country!", e);
				country = UNKNOWN_COUNTRY;
			}
			
			if (! UNKNOWN_COUNTRY.equals(country)) {
				CouchDbClient db = CouchDBUtil.getClient(CouchDatabase.COUNTRIES);
				JsonObject obj = db.find(JsonObject.class, country.toUpperCase());
				
				String[] bannedRegions = obj.get("Blocked_list").toString().replaceAll("\"", "").split(",");
				if (bannedRegions != null && bannedRegions.length > 0) {
					for (String region : bannedRegions) {
						if (! StringUtilities.isEmpty(region.trim())) {
							country += BANNED_SUFFIX;
							break;
						}
					}
				}
			}
			
			request.getSession().setAttribute(SESSION_COUNTRY_KEY, country);
		}
		
		boolean blocked = country.endsWith(BANNED_SUFFIX);
		if (blocked) {
			String url = request.getRequestURI();
			//XXX:  should we preserve this filter, or just ban requests to any resource (except for 'Unauthorized')?  [probably the latter]
			if (url.equalsIgnoreCase("/") || url.contains("index.html") || url.contains("indexPage") 
							|| "indexPage".equals(request.getParameter("method"))) {
				response.sendRedirect("/Unauthorized.html");
			}
		} 
	}
	
	private static DatabaseReader getReader() throws IOException {
		if (reader == null) {
			//XXX:  ideally should never happen, as the field should be initialized before we ever get a call to 'getReader()'
			File database = new File(BaseSpringController.getWebappBasePath() + "WEB-INF/geoip/GeoLite2-Country.mmdb");
			reader = new DatabaseReader.Builder(database).build();
		}
		
		return reader;
	}
	
	private String getEndpointAddress(HttpServletRequest request) {
		String remoteAddress = request.getRemoteAddr();
		String headerIP = request.getHeader("X-Forwarded-For");
		if (StringUtilities.isEmpty(headerIP)) {
			headerIP = request.getHeader("X-FORWARDED-FOR");
		}
		
		if (! StringUtilities.isEmpty(headerIP) && ("localhost".equalsIgnoreCase(remoteAddress) || 
				"127.0.0.1".equals(remoteAddress) || "::1".equals(remoteAddress))) {
			remoteAddress = headerIP;
		}
		
		return remoteAddress;
	}
}
