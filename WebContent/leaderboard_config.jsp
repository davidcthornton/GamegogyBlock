<%@ taglib uri="/bbNG" prefix="bbNG"%>

<bbNG:modulePage type="personalize" ctxId="ctx">
<bbNG:pageHeader>
<bbNG:pageTitleBar title="Leaderboard Configuration"></bbNG:pageTitleBar>
</bbNG:pageHeader>
<!-- Body Content: Plotbands & Color Picker -->
	<bbNG:form action="leaderboard_save.jsp" method="post" onsubmit="javascript:history.go(-1)">
		<bbNG:dataCollection>
			<bbNG:step title="Plotbands Configuration">
				<bbNG:dataElement label="Plotbands Color">
					<bbNG:colorPicker name="color" />
				</bbNG:dataElement>
				<form name="plotband_config_form">
					Level 1 - From: <input type="text" name="Level1_from" size="3"/> To: <input type="text" name="Level1_to" size="3"/><br/>
					Level 2 - From: <input type="text" name="Level2_from" size="3"/> To: <input type="text" name="Level2_to" size="3"/><br/>
					Level 3 - From: <input type="text" name="Level3_from" size="3"/> To: <input type="text" name="Level3_to" size="3"/><br/>
					Level 4 - From: <input type="text" name="Level4_from" size="3"/> To: <input type="text" name="Level4_to" size="3"/><br/>
					Level 5 - From: <input type="text" name="Level5_from" size="3"/> To: <input type="text" name="Level5_to" size="3"/><br/>
				</form>
			</bbNG:step>
			<bbNG:stepSubmit />
		</bbNG:dataCollection>
	</bbNG:form>
</bbNG:modulePage>