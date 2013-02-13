<%@page import="blackboard.base.*"%>
<%@page import="blackboard.data.course.*"%> 				<!-- for reading data -->
<%@page import="blackboard.data.user.*"%> 					<!-- for reading data -->
<%@page import="blackboard.persist.*"%> 					<!-- for writing data -->
<%@page import="blackboard.persist.course.*"%> 				<!-- for writing data -->
<%@page import="blackboard.platform.gradebook2.*"%>
<%@page import="blackboard.platform.gradebook2.impl.*"%>
<%@page import="java.util.*"%> 								<!-- for utilities -->
<%@page import="blackboard.platform.plugin.PlugInUtil"%>	<!-- for utilities -->
<%@ taglib uri="/bbData" prefix="bbData"%> 					<!-- for tags -->
<%@ taglib uri="/bbNG" prefix="bbNG"%>
<%@page import="com.spvsoftwareproducts.blackboard.utils.B2Context"%>

<%
if (request.getMethod().equalsIgnoreCase("POST")) {
	
	// Create a new persistence object.  Don't save empty fields.
	B2Context b2Context = new B2Context(request);
	b2Context.setSaveEmptyValues(false);
	
	// Get level values from user-submitted data and add it to the persistence object.
	for(int i = 0; i < 10; i++) {
		b2Context.setSetting(false, true, "Level_" + (i+1) + "_Points", request.getParameter("Level_" + (i+1) + "_Points"));
	}
	
	// Get color value from user-submitted data and add it to the persistence object.
	b2Context.setSetting(false, true, "color", request.getParameter("color"));
	
	// Save the settings (COURSE-WIDE)
	b2Context.persistSettings(false, true);
}

// May need error checking logic here (gaps in level fields, overlapping values, etc.)

// Send user back to course home page
String s = "<script>history.go(-2);</script>";

%>

<%=s %>