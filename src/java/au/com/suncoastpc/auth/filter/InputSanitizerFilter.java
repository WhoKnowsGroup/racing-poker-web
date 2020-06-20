package au.com.suncoastpc.auth.filter;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import au.com.suncoastpc.auth.util.OverridableHttpRequest;

public class InputSanitizerFilter implements Filter {
	private static final Logger LOG = Logger.getLogger(InputSanitizerFilter.class);
	
	private static final String BANNED_INPUT_CHARS = ".*[^a-zA-Z0-9\\@\\'\\,\\.\\/\\(\\)\\+\\=\\-\\_\\[\\]\\{\\}\\^\\!\\*\\&\\%\\$\\:\\;\\? \\t]+.*";
	
	public static final String QUARANTINE_ATTRIBUTE_NAME = "auth.quarantined.params";
	public static final String SUSPICIOUS_REQUEST_FLAG_NAME = "auth.suspicious.request";

	@Override
	public void destroy() {
		//no work necessary
	}

	@SuppressWarnings("unchecked")
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		OverridableHttpRequest newRequest = request instanceof OverridableHttpRequest ? (OverridableHttpRequest)request :new OverridableHttpRequest((HttpServletRequest)request);
		Map<String, String> quarantine = (Map<String, String>)newRequest.getAttribute(QUARANTINE_ATTRIBUTE_NAME);  //XXX:  check for a pre-existing quarantine here in case we are invoked multiple times; for example as a result of @RemapsMultipartUploads
		if (quarantine == null) {
			quarantine = new HashMap<String, String>();
		}
		newRequest.setAttribute(QUARANTINE_ATTRIBUTE_NAME, quarantine);
		
		//XXX:  this works for GET and POST, but will not process a multipart upload
		Enumeration<String> names = request.getParameterNames();
		while (names.hasMoreElements()) {
			String name = names.nextElement();
			String value = request.getParameter(name);
			//LOG.debug("Inspecting param:  " + name + "=" + value);
			if (value.matches(BANNED_INPUT_CHARS)) {
				LOG.warn("Removing potentially malicious parameter from request:  " + name);
				quarantine.put(name, value);
				newRequest.removeParameter(name);
				newRequest.setAttribute(SUSPICIOUS_REQUEST_FLAG_NAME, "true");
			}
		}
		
		if (chain != null) {
			chain.doFilter(newRequest, response);
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		//no work necessary
	}

}
