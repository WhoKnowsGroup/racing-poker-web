<%@ taglib tagdir="/WEB-INF/tags" prefix="rp" %>
<%@ taglib tagdir="/WEB-INF/tags/v2" prefix="v2" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- common-js -->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
    window.jQuery || document.write('<script src="/Jquery/jquery_min/jquery.min.js"><\/script>')
</script>
<script src="/Jquery/jquery-md5.js"></script>
<script src="/js/lib/plugins.js"></script>
<script src="/js/selectordie.min.js"></script>
<script src="/js/main.js"></script>
<script type="text/javascript" src="/js/slick.min.js"></script>
<script src="//code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/cookieconsent@3/build/cookieconsent.min.js" data-cfasync="false"></script>
<script>
$(document).ready(function() {
	window.cookieconsent.initialise({
	  "palette": {
	    "popup": {
	      "background": "#216942",
	      "text": "#b2d192"
	    },
	    "button": {
	      "background": "#afed71"
	    }
	  },
	  "content": {
	    "message": "This website uses cookies to ensure you get the best experience possible.",
	    "href": "/r/legals?selectedTab=privacy"
	  }
	});
});
</script>
<!-- /common-js -->