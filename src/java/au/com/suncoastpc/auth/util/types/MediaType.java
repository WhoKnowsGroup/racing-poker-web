package au.com.suncoastpc.auth.util.types;

public enum MediaType {
	IMAGE("image/png-or-jpeg"),	//JPG or PNG Format
	AUDIO("audio/mpeg"),		//MP3 or AAC Audio Format
	VIDEO("video/mpeg"),		//H.264 Video Format with AAC Audio Format
	PDF("application/binary");	//PDF documents
	
	private String mimeType;
	
	private MediaType(String mime) {
		this.mimeType = mime;
	}

	public String getMimeType() {
		return mimeType;
	}
}
