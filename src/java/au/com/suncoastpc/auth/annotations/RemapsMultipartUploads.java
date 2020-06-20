package au.com.suncoastpc.auth.annotations;

import java.lang.annotation.Annotation;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

import au.com.suncoastpc.auth.filter.InputSanitizerFilter;
import au.com.suncoastpc.auth.util.OverridableHttpRequest;

/**
 * This annotation can be used to have the server automatically parse a 
 * multipart upload and remap all the content from within that upload 
 * so that it can be accessed via standard request parameters.  This allows 
 * for the same code to be used to handle multipart and standard HTTP requests.
 * 
 *  Note that this annotation only remaps form fields to parameters.  Any files that are 
 *  included in the request are collected and exposed via a request attribute.
 * 
 * @author Adam
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD, ElementType.TYPE})
public @interface RemapsMultipartUploads {
	public static final String REMAPPED_ATTRIB = "__remapped";
	String filesAttribName() default "_files";
	
	public static class Processor implements AnnotationProcessor {
		private static final Logger LOG = Logger.getLogger(RemapsMultipartUploads.class);
		
		@SuppressWarnings("unchecked")
		@Override
		public boolean processRequest(Annotation theAnnotation, HttpServletRequest request, HttpServletResponse response) {
			if (! (theAnnotation instanceof RemapsMultipartUploads)) {
				//someone made an invalid call, just return true
				return true;
			}
			
			List<FileItem> items = Collections.emptyList();
			RemapsMultipartUploads annotation = (RemapsMultipartUploads)theAnnotation;
			if (ServletFileUpload.isMultipartContent(request)) {
				// Create a factory for disk-based file items
				FileItemFactory factory = new DiskFileItemFactory();

				// Create a new file upload handler
				ServletFileUpload upload = new ServletFileUpload(factory);
				
				try {
					request.getInputStream().mark(Integer.MAX_VALUE);
					items = upload.parseRequest(request);
					request.getInputStream().reset();
				}
				catch (Throwable e) {
					LOG.error("Unexpected exception when processing annotation", e);
					return false;
				}
			}
			
			List<FileItem> uploads = new ArrayList<FileItem>();
			OverridableHttpRequest newRequest = ((OverridableHttpRequest)request);
			for (FileItem item : items) {
				if (item.isFormField()) {
					newRequest.setParameter(item.getFieldName(), item.getString());
				}
				else {
					uploads.add(item);
				}
			}
			newRequest.setAttribute(annotation.filesAttribName(), uploads);
			
			//XXX:  hack; the input filter can't handle multipart uploads directly, but after we remap the parameters it can process it
			try {
				new InputSanitizerFilter().doFilter(newRequest, null, null);
			}
			catch (Exception ignored) { ignored.printStackTrace(); }
			
			newRequest.setAttribute(REMAPPED_ATTRIB, "true");
			
			return true;
		}
		
		@Override
		public boolean validatesBeforeExecution() {
			return true;
		}

		@Override
		public boolean validatesAfterExecution() {
			return false;
		}
	}
}	
