<%@ taglib uri="/bbNG" prefix="bbNG"%>

<bbNG:modulePage type="personalize" ctxId="ctx">
<bbNG:pageHeader>
<bbNG:pageTitleBar title="Leaderboard Configuration"></bbNG:pageTitleBar>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js" type="text/javascript">
</script>
<script type="text/javascript">
var lastLevel = 3;		//Represents the last visible level.

//Add level.
function pushLevel(){
	if(lastLevel<10){
		lastLevel += 1;
		switch(lastLevel){
			case 4: 
				$("#Level_4").show(); 
				$("#popLevel_button").removeAttr('disabled');
			break;
			case 5: $("#Level_5").show(); break;
			case 6: $("#Level_6").show(); break;
			case 7: $("#Level_7").show(); break;
			case 8: $("#Level_8").show(); break;
			case 9: $("#Level_9").show(); break;
			case 10: 
				$("#Level_10").show(); 
				$("#pushLevel_button").attr('disabled','disabled');
			break;
		}
	}
}

//Remove level.
function popLevel(){
	if(lastLevel>3){
		switch(lastLevel){
			case 4: 
				$("#Level_4").hide(); 
				$("#popLevel_button").attr('disabled','disabled');
			break;
			case 5: $("#Level_5").hide(); break;
			case 6: $("#Level_6").hide(); break;
			case 7: $("#Level_7").hide(); break;
			case 8: $("#Level_8").hide(); break;
			case 9: $("#Level_9").hide(); break;
			case 10: 
				$("#Level_10").hide(); 
				$("#pushLevel_button").removeAttr('disabled');
			break;
		}
		lastLevel -= 1;
	}
}

//When the document loads, run defaultLevels().
$(document).ready(function(){
	$("#popLevel_button").click(function(){
		popLevel();
	});
	$("#pushLevel_button").click(function(){
		pushLevel();
	});
});
</script>

</bbNG:pageHeader>
<!-- Body Content: Plotbands & Color Picker -->
	<bbNG:form action="leaderboard_save.jsp" method="post" onsubmit="javascript:history.go(-1)">
		<bbNG:dataCollection>
			<bbNG:step title="Plotbands Configuration">
				<bbNG:dataElement label="Plotbands Color">
					<bbNG:colorPicker name="color" />
				</bbNG:dataElement>
				<form name="plotband_config_form">
					<table>
						<tr id="Level_1">
							<td>Level 1 -</td>
							<td>Points: <input type="text" name="Level_1_Points" size="3"/></td>
						</tr>
						<tr id="Level_2">
							<td>Level 2 -</td>
							<td>Points: <input type="text" name="Level_2_Points" size="3"/></td> 
						</tr>
						<tr id="Level_3">
							<td>Level 3 -</td>
							<td>Points: <input type="text" name="Level_3_Points" size="3"/></td> 
						</tr>
						<tr id="Level_4">
							<td>Level 4 -</td>
							<td>Points: <input type="text" name="Level_4_Points" size="3"/></td> 
						</tr>
						<tr id="Level_5">
							<td>Level 5 -</td>
							<td>Points: <input type="text" name="Level_5_Points" size="3"/></td> 
						</tr>
						<tr id="Level_6">
							<td>Level 6 -</td>
							<td>Points: <input type="text" name="Level_6_Points" size="3"/></td> 
						</tr>
						<tr id="Level_7">
							<td>Level 7 -</td>
							<td>Points: <input type="text" name="Level_7_Points" size="3"/></td> 
						</tr>
						<tr id="Level_8">
							<td>Level 8 -</td>
							<td>Points: <input type="text" name="Level_8_Points" size="3"/></td> 
						</tr>
						<tr id="Level_9">
							<td>Level 9 -</td>
							<td>Points: <input type="text" name="Level_9_Points" size="3"/></td> 
						</tr>
						<tr id="Level_10">
							<td>Level 10 -</td>
							<td>Points: <input type="text" name="Level_10_Points" size="3"/></td> 
						</tr>
					</table>
					<button id="popLevel_button" type="button" disabled>-</button>
					<button id="pushLevel_button" type="button">+</button>
				</form>
				<script>
				$("#Level_4").hide();
				$("#Level_5").hide();
				$("#Level_6").hide();
				$("#Level_7").hide();
				$("#Level_8").hide();
				$("#Level_9").hide();
				$("#Level_10").hide();
				</script>
			</bbNG:step>
			<bbNG:stepSubmit />
		</bbNG:dataCollection>
	</bbNG:form>
</bbNG:modulePage>