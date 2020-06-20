package com.pokerace.purchases.spring;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import au.com.suncoastpc.auth.spring.base.BaseSpringController;

@WebServlet(value="/paypalHandler/*", initParams = {
				@WebInitParam(name="contextConfigLocation", value="/WEB-INF/spring-servlet.xml")
		})
public class PaypalValidationController extends BaseSpringController {
	/**
	 * Serialization ID
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected Class<? extends MultiActionController> getControllerClass() {
		return PaypalValidationMethods.class;
	}

	@Override
	protected String getMethodMappingParamName() {
		return "method";
	}

	@Override
	protected String getPageNameForView(ModelAndView mv) {
		// TODO Auto-generated method stub
		return null;
	}

}
