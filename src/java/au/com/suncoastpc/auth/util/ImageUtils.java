package au.com.suncoastpc.auth.util;

import java.awt.Graphics;
import java.awt.GraphicsConfiguration;
import java.awt.GraphicsDevice;
import java.awt.GraphicsEnvironment;
import java.awt.HeadlessException;
import java.awt.Image;
import java.awt.Transparency;
import java.awt.color.ColorSpace;
import java.awt.color.ICC_ColorSpace;
import java.awt.color.ICC_Profile;
import java.awt.image.BufferedImage;
import java.awt.image.ColorModel;
import java.awt.image.PixelGrabber;
import java.awt.image.Raster;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Iterator;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;
import javax.swing.ImageIcon;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.apache.log4j.lf5.util.StreamUtils;
import org.apache.sanselan.Sanselan;

import au.com.suncoastpc.auth.spring.base.BaseSpringController;

public class ImageUtils {
	private static final Logger LOG = Logger.getLogger(ImageUtils.class);
	
	public static BufferedImage toBufferedImage(Image image) {
	    if (image instanceof BufferedImage) {
	        return (BufferedImage)image;
	    }

	    // This code ensures that all the pixels in the image are loaded
	    image = new ImageIcon(image).getImage();

	    // Determine if the image has transparent pixels; for this method's
	    // implementation, see Determining If an Image Has Transparent Pixels
	    boolean hasAlpha = hasAlpha(image);

	    // Create a buffered image with a format that's compatible with the screen
	    BufferedImage bimage = null;
	    GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
	    try {
	        // Determine the type of transparency of the new buffered image
	        int transparency = Transparency.OPAQUE;
	        if (hasAlpha) {
	            transparency = Transparency.BITMASK;
	        }

	        // Create the buffered image
	        GraphicsDevice gs = ge.getDefaultScreenDevice();
	        GraphicsConfiguration gc = gs.getDefaultConfiguration();
	        bimage = gc.createCompatibleImage(
	            image.getWidth(null), image.getHeight(null), transparency);
	    } catch (HeadlessException e) {
	        // The system does not have a screen
	    }

	    if (bimage == null) {
	        // Create a buffered image using the default color model
	        int type = BufferedImage.TYPE_INT_RGB;
	        if (hasAlpha) {
	            type = BufferedImage.TYPE_INT_ARGB;
	        }
	        bimage = new BufferedImage(image.getWidth(null), image.getHeight(null), type);
	    }

	    // Copy image to buffered image
	    Graphics g = bimage.createGraphics();

	    // Paint the image onto the buffered image
	    g.drawImage(image, 0, 0, null);
	    g.dispose();

	    return bimage;
	}
	
	@SuppressWarnings("unused")
	private static BufferedImage readImage(File imageFile) throws Exception {
		return ImageIO.read(imageFile);
	}
	
	private static BufferedImage readImageConvertingIfNecessary(File imageFile) throws Exception {
		BufferedImage result = null;
		try {
			//see if we can just read the file directly
			result = ImageIO.read(imageFile);
		}
		catch (Throwable e) {
			LOG.warn("Failed to read file at '" + imageFile.getAbsolutePath() + "', will attempt colorspace conversion...");
			
			//load the colorspace to use for the image
			ICC_Profile iccProfile = Sanselan.getICCProfile(imageFile);
			if (iccProfile == null) {
				iccProfile = ICC_Profile.getInstance(BaseSpringController.getWebappBasePath() + "WEB-INF/icc/USWebCoatedSWOP.icc");
			}
			ColorSpace cs = new ICC_ColorSpace(iccProfile);    
			
			//Find a suitable ImageReader
			ImageReader reader = null;
		    Iterator<ImageReader> readers = ImageIO.getImageReadersByFormatName("jpeg");		//XXX:  only JPEG's can be in CMYK; PNG images will always use RGB
		    while(readers.hasNext()) {
		        reader = readers.next();
		        if(reader.canReadRaster()) {
		            break;
		        }
		    }

		    //Stream the image file (the original CMYK image)
		    ImageInputStream input = ImageIO.createImageInputStream(imageFile); 
		    reader.setInput(input); 

		    //Read the image raster
		    Raster raster = reader.readRaster(0, null); 
		    input.close();
		    
		    //we have to convert the color space, because Java tries to put an alpha-channel into the jpeg
		    float[] rgbPixels = null;
		    int[] intRgb = new int[3];
		    int width = raster.getWidth();
		    int height = raster.getHeight();
		    float[] cmykPixels = new float[4];
		    int[] convertedPixels = new int[width * height];
		    for (int y = 0; y < height; y++) {
		    	for (int x = 0; x < width; x++) {
		    		cmykPixels = raster.getPixel(x, y, cmykPixels);
		    		for (int index = 0; index < cmykPixels.length; index++) {
		    			cmykPixels[index] /= 255.0;
		    			cmykPixels[index] = 1.0f - cmykPixels[index];
		    		}
		    		
		    		rgbPixels = cs.toRGB(cmykPixels);
		    		intRgb[0] = (int)(rgbPixels[0] * 255);
		    		intRgb[1] = (int)(rgbPixels[1] * 255);
		    		intRgb[2] = (int)(rgbPixels[2] * 255);
		    		convertedPixels[width * y + x] = 0x00FFFFFF & ((intRgb[0] << 16) | (intRgb[1] << 8) | intRgb[2]);
		    	}
		    }
		    
		    //get a usable temporary file
		    File tempFile = new File(imageFile.getAbsolutePath() + ".tmp");
		    
		    //write the converted image out to a temporary location
		    BufferedImage converted = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		    converted.setRGB(0, 0, width, height, convertedPixels, 0, width);
		    ImageIO.write(converted, "jpeg", tempFile);
		    
		    //overwrite the original source image and delete the temp file
		    FileUtils.copyFile(tempFile, imageFile);
		    tempFile.delete();
		    
		    //read the converted file back in
		    result = ImageIO.read(imageFile);//converted;
		    
		    LOG.debug("Conversion completed successfully!");
		}
		
		return result;
	}
	
	@SuppressWarnings("unused")
	private static boolean saveToFile(FileItem upload, String path) {
		try {
			
			InputStream uploadedStream = upload.getInputStream();
			StreamUtils.copy(uploadedStream, new FileOutputStream(path));
		}
		catch (Exception e) {
			LOG.warn("Could not create a file from the provided stream; path=" + path, e);
			return false;
		}
		
		File uploadedFile = new File(path);
		if (uploadedFile.length() < 1) {
			//empty files are not allowed
			LOG.warn("Got a file of 0 length, it will be deleted; path=" + path);
			uploadedFile.delete();
			return false;
		}
		
		return true;
	}
	
	//XXX:  package access intentional
	static boolean scaleImageFile(File uploadedFile, int targetWidth, int targetHeight) {
		try {
			BufferedImage image = readImageConvertingIfNecessary(uploadedFile);//ImageIO.read(uploadedFile);
			
			Image scaledImage = image.getScaledInstance(targetWidth, targetHeight, Image.SCALE_SMOOTH);
			ImageIO.write(ImageUtils.toBufferedImage(scaledImage), "png", uploadedFile);
		}
		catch (Exception e) {
			LOG.warn("The provided file is not an image, it will be deleted; path=" + uploadedFile.getAbsolutePath(), e);
			uploadedFile.delete();
			return false;
		}
		
		return true;
	}
	
	public static Image aspectFitImage(File uploadedFile, int maxWidth, int maxHeight) {
		return aspectFitImage(uploadedFile, uploadedFile, maxWidth, maxHeight);
	}
	
	public static Image aspectFitImage(File uploadedFile, File outputFile, int maxWidth, int maxHeight) {
		Image scaledImage = null;
		try {
			BufferedImage image = readImageConvertingIfNecessary(uploadedFile);//ImageIO.read(uploadedFile);
			double scaleX = image.getWidth() > maxWidth ? maxWidth / (double)image.getWidth() : 1.0;
			double scaleY = image.getHeight() > maxHeight ? maxHeight / (double)image.getHeight() : 1.0;
			double useScale = scaleX < scaleY ? scaleX : scaleY;
			
			scaledImage = image.getScaledInstance((int)(image.getWidth() * useScale), (int)(image.getHeight() * useScale), Image.SCALE_SMOOTH);
			ImageIO.write(ImageUtils.toBufferedImage(scaledImage), "png", outputFile);
		}
		catch (Exception e) {
			LOG.warn("The provided file is not an image, it will be deleted; path=" + uploadedFile.getAbsolutePath(), e);
			uploadedFile.delete();
			return null;
		}
		
		return scaledImage;
	}
	
	private static boolean hasAlpha(Image image) {
		// If buffered image, the color model is readily available
		if (image instanceof BufferedImage) {
			BufferedImage bimage = (BufferedImage) image;
			return bimage.getColorModel().hasAlpha();
		}

		// Use a pixel grabber to retrieve the image's color model;
		// grabbing a single pixel is usually sufficient
		PixelGrabber pg = new PixelGrabber(image, 0, 0, 1, 1, false);
		try {
			pg.grabPixels();
		} catch (InterruptedException e) {
		}

		// Get the image's color model
		ColorModel cm = pg.getColorModel();
		return cm.hasAlpha();
	}
}
