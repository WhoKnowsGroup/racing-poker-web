package au.com.suncoastpc.auth.spring;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import au.com.suncoastpc.auth.spring.base.BaseSpringController;

@WebServlet(value="/user/*", initParams = {
		@WebInitParam(name="contextConfigLocation", value="/WEB-INF/spring-servlet.xml")
})
public class PostAuthController extends BaseSpringController {
	/**
	 * Serialization id.
	 */
	private static final long serialVersionUID = 1L;
	
	
	@Override
	protected Class<? extends MultiActionController> getControllerClass() {
		return PostAuthMethods.class;
	}
	
	@Override
	protected String getMethodMappingParamName() {
		return "method";
	}
	
	@Override
	protected String getPageNameForView(ModelAndView mv) {
		return null;
	}
}