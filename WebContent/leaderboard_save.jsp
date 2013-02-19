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
	
	if(request.getParameter("instructor") == "true") {
		// Create a new persistence object for course settings.  Don't save empty fields.
		B2Context b2Context_c = new B2Context(request);
		b2Context_c.setSaveEmptyValues(false);
		
		// Get level values from user-submitted data and add it to the persistence object.
		for(int i = 0; i < 10; i++) {
			b2Context_c.setSetting(false, true, "Level_" + (i+1) + "_Points", request.getParameter("Level_" + (i+1) + "_Points"));
		}
		
		// Save course settings
		b2Context_c.persistSettings(false, true);
	}
	
	// New persistence object for user-specific settings
	B2Context b2Context_u = new B2Context(request);
	
	// Get color value from user-submitted data and add it to the persistence object.
	b2Context_u.setSetting(true, false, "color", request.getParameter("color"));
	b2Context_u.setSetting(true, false, "user_color", request.getParameter("user_color"));
	
	// Save the settings (USER-SPECIFIC)
	b2Context_u.persistSettings(true, false);
}

// May need error checking logic here (gaps in level fields, overlapping values, etc.)

// Send user back to course home page
String s = "<script>history.go(-2);</script>";

%>

<%=s %>