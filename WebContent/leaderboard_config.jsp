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
	session.invalidate();	// Discard old session if one exists
	String [] level_values = new String[10];
	
	B2Context b2Context = new B2Context(request);
	b2Context.setSaveEmptyValues(false);
	for(int i = 0; i < 10; i++){
		level_values[i] = b2Context.getSetting(false, true, "Level_" + (i+1) + "_Points");
	}
%>

<bbNG:modulePage type="personalize" ctxId="ctx">
<bbNG:pageHeader>
<bbNG:pageTitleBar title="Leaderboard Configuration"></bbNG:pageTitleBar>
</bbNG:pageHeader>

<!-- Body Content: Plotbands & Color Picker -->
	<bbNG:form action="leaderboard_save.jsp" method="post">
		<bbNG:dataCollection>
			<bbNG:step title="Plotbands Configuration">
				<bbNG:dataElement label="Plotbands Color">
					<bbNG:colorPicker name="color" />
				</bbNG:dataElement>
				<form name="plotband_config_form" id="plotband_config_form" onkeydown="checkForm()">
					<table>
						<tr id="Level_1">
							<td>Level 1 -</td>
							<td>Points: <input type="text" name="Level_1_Points" size="3" value="<%=level_values[0]%>"/></td>
						</tr>
						<tr id="Level_2">
							<td>Level 2 -</td>
							<td>Points: <input type="text" name="Level_2_Points" size="3" value="<%=level_values[1]%>"/></td> 
						</tr>
						<tr id="Level_3">
							<td>Level 3 -</td>
							<td>Points: <input type="text" name="Level_3_Points" size="3" value="<%=level_values[2]%>"/></td> 
						</tr>
						<tr id="Level_4">
							<td>Level 4 -</td>
							<td>Points: <input type="text" name="Level_4_Points" size="3" value="<%=level_values[3]%>"/></td> 
						</tr>
						<tr id="Level_5">
							<td>Level 5 -</td>
							<td>Points: <input type="text" name="Level_5_Points" size="3" value="<%=level_values[4]%>"/></td> 
						</tr>
						<tr id="Level_6">
							<td>Level 6 -</td>
							<td>Points: <input type="text" name="Level_6_Points" size="3" value="<%=level_values[5]%>"/></td> 
						</tr>
						<tr id="Level_7">
							<td>Level 7 -</td>
							<td>Points: <input type="text" name="Level_7_Points" size="3" value="<%=level_values[6]%>"/></td> 
						</tr>
						<tr id="Level_8">
							<td>Level 8 -</td>
							<td>Points: <input type="text" name="Level_8_Points" size="3" value="<%=level_values[7]%>"/></td> 
						</tr>
						<tr id="Level_9">
							<td>Level 9 -</td>
							<td>Points: <input type="text" name="Level_9_Points" size="3" value="<%=level_values[8]%>"/></td> 
						</tr>
						<tr id="Level_10">
							<td>Level 10 -</td>
							<td>Points: <input type="text" name="Level_10_Points" size="3" value="<%=level_values[9]%>"/></td> 
						</tr>
					</table>
					<input id="popLevel_button" type="button" value="-" onclick="subtractLevel()"/>
					<input id="pushLevel_button" type="button" value="+" onclick="addLevel()"/>
					<input type="reset" value="Reset" />
				</form>
				<script type="text/javascript">
					// hide higher levels (4-10) initially
					for(var i = 4; i <= 10; i++) {
						document.getElementById("Level_" + i).style.visibility = "hidden";
					}
					
					function addLevel() {
						for(var i = 4; i <= 10; i++) {
							if(document.getElementById("Level_" + i).style.visibility == "hidden") {
								document.getElementById("Level_" + i).style.visibility = "visible";
								checkForm();
								return;
							}
						}
					}
					
					function subtractLevel() {
						for(var i = 10; i >= 4; i--) {
							if(document.getElementById("Level_" + i).style.visibility == "visible") {
								document.getElementById("Level_" + i).style.visibility = "hidden";
								checkForm();
								return;
							}
						}
					}
					
					function checkForm() {
						for(var i = 2; i <= 10; i++) {
							if(document.getElementsByName("Level_" + (i-1) + "_Points")[0].value == "" 
							|| document.getElementsByName("Level_" + (i-1) + "_Points")[0].disabled) {
								document.getElementsByName("Level_" + i + "_Points")[0].disabled = true;
							} else {
								document.getElementsByName("Level_" + i + "_Points")[0].disabled = false;
							}
						}
					}
					checkForm();
				</script>
			</bbNG:step>
			<bbNG:stepSubmit />
		</bbNG:dataCollection>
	</bbNG:form>
</bbNG:modulePage>