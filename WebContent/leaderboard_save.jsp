<%

// Process leaderboard config here.
 
String levels, color;

levels = request.getParameter("plotbands_config");
color  = request.getParameter("color");

// Persistence logic here...





// Send user back to course home page
// Dirty...  Need to find a better way to run this page silently
String s = "<script>history.go(-2);</script>";

%>

<%=s %>
<!-- [Test Page]

<%@ taglib uri="/bbNG" prefix="bbNG"%>
<bbNG:modulePage type="personalize" ctxId="ctx">
<bbNG:pageHeader>
<bbNG:pageTitleBar title="Leaderboard Configuration"></bbNG:pageTitleBar>
</bbNG:pageHeader>
<bbNG:receipt type="SUCCESS" iconUrl="../images/B2-32.jpg" title="Information Saved" recallUrl="javascript:history.go(-2)">

</bbNG:receipt>
</bbNG:modulePage>

//-->