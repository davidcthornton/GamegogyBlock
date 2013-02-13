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

// Persistence logic here...

if (request.getMethod().equalsIgnoreCase("POST")) {
	// Process leaderboard config here.
	B2Context b2Context = new B2Context(request);
	b2Context.setSaveEmptyValues(false);
	
	for(int i = 0; i < 10; i++) {
		b2Context.setSetting(false, true, "Level_" + (i+1) + "_Points", request.getParameter("Level_" + (i+1) + "_Points"));
	}
	
	b2Context.persistSettings(false, true);
}



// Send user back to course home page
// Dirty...  Need to find a better way to run this page silently
String s = "<script>history.go(-2);</script>";

%>

<%=s %>