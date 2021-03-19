<%@ page import="java.nio.charset.StandardCharsets,
					java.security.MessageDigest,
					java.security.NoSuchAlgorithmException,
					java.util.Base64,
					java.io.ByteArrayOutputStream,
					java.io.FileNotFoundException,
					java.io.IOException,
					java.io.InputStream,
					org.apache.hc.client5.http.classic.methods.HttpGet,
					org.apache.hc.client5.http.impl.classic.CloseableHttpClient,
					org.apache.hc.client5.http.impl.classic.CloseableHttpResponse,
					org.apache.hc.client5.http.impl.classic.HttpClientBuilder,
					org.apache.hc.client5.http.impl.classic.HttpClients,
					org.apache.hc.core5.http.HttpEntity"
%>
<%!
	public static InputStream getStream(String url) {
		InputStream is = null;
		HttpEntity entity = null;
		try (CloseableHttpClient httpclient = HttpClients.createDefault()) {
			HttpGet httpGet = new HttpGet("http://localhost:8080/examples/react.pdf");
			try (CloseableHttpResponse response1 = httpclient.execute(httpGet)) {
				System.out.println(response1.getCode() + " " + response1.getReasonPhrase());
				//is = response1.getEntity().getContent();
				is = response1.getEntity().getContent();
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return is;
	}
	public static String getDocumentHash(String filePath) {
		String returnValue = "script-src 'self'";
		return returnValue+" "+"'sha256-"+base64Encode(getPdfHash(filePath))+"'";
	}
	public static String base64Encode(String documentHash) {
		return Base64.getEncoder().encodeToString(documentHash.getBytes());
	}
	public static String getDocumentDigest(String input ) {
		String output="";
		try {
			MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
			messageDigest.update(input.getBytes());
			output = new String(messageDigest.digest());
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return output;
	}		
	public static String getPdfHash(String pdfFilePath) {
		String output = "";
		java.io.FileInputStream fileInputStream = null	;
		try {
			fileInputStream = getFileInputStream(pdfFilePath);
			ByteArrayOutputStream buffer = new ByteArrayOutputStream();

			int nRead;
			byte[] data = new byte[16384];

			while ((nRead = fileInputStream.read(data, 0, data.length)) != -1) {
			  buffer.write(data, 0, nRead);
			}

			 buffer.toByteArray();
			
			MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
			messageDigest.update(buffer.toByteArray());
			output = new String(messageDigest.digest());
		} catch (FileNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 

		return output;
	}
	private static java.io.FileInputStream getFileInputStream(String pdfFilePath) throws FileNotFoundException {
		java.io.FileInputStream fileInputStream;
		fileInputStream=new java.io.FileInputStream(pdfFilePath);
		return fileInputStream;
	}
%>
<%
	//Oracle WebCenter Content Server
	//var contentInformation = hrefHost + "/cs/idcplg?IdcService=DOC_INFO_BY_NAME&dDocName=" + docID + "&IsJson=1";
	//format, dID, statusMsg, docURL
	//https://wcc.prd.cimicapps.com/cs/resources/apwf/apwfalternativeviewer.html?documentId=3.IPM_7255671&IPMImageLink=O&AnnotationsY
	//https://wcc.uat.cimicapps.com/cs/fsnew/groups/ipmsys_app_1/documents/document/000/000/004/677/ipm_4677230.pdf
	//<meta http-equiv="Content-Security-Policy" content="script-src 'self' 'sha256-Nhpm6Nk4BC2bp32YROELu4tQkiUW1ybS16Lb53c/uY4=' 'sha256-bAGrAucHI7f0JJjm0m1t4X6CWG1yeg/Q7wtin50cGDw=' 'sha256-OfhWWTf2//P+ikwB/8eqSnQvAY54y+3UkWmKbYIeK6s=' ">
	//https://docs.oracle.com/cd/E14571_01/doc.1111/e10624/c07_servers.htm#DISUS258
	//DomainHome/ucm/cs/weblayout/jsp/
	//var loc = hrefHost + "/cs/idcplg?IdcService=GET_FILE&dID="+dID;//For tiff files 
	//ICISTransferStream transferStream = fileAPI.getFile (context, documentID);
		
	response.setContentType("APPLICATION/pdf");
	//response.addHeader("Content-Security-Policy", "default-src 'self' ");
	String filePath = "C:\\Users\\vivij\\Downloads\\apache-tomcat-9.0.44-windows-x64\\apache-tomcat-9.0.44\\webapps\\examples\\react.pdf";
	response.addHeader("Content-Security-Policy", getDocumentHash(filePath));
	//response.addHeader("Content-Security-Policy", "sandbox");

	
	//String filePath = ".//react.pdf";
	java.io.FileInputStream fileInputStream=new java.io.FileInputStream(filePath);  
	
	java.io.OutputStream outStream = response.getOutputStream();
	
	byte[] buffer = new byte[4096];
		int bytesRead = -1;
	while ((bytesRead = fileInputStream.read(buffer)) != -1) {
			outStream.write(buffer, 0, bytesRead);
		}		
	
	fileInputStream.close();   

%>