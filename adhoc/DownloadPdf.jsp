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
	response.addHeader("Content-Security-Policy", "default-src 'self'");

	String filePath = "C:\\Users\\vivij\\Downloads\\apache-tomcat-9.0.44-windows-x64\\apache-tomcat-9.0.44\\webapps\\examples\\react.pdf";
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