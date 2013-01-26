<%@ taglib uri="/bbNG" prefix="bbNG"%>

<bbNG:modulePage type="personalize" ctxId="ctx">
<bbNG:pageHeader>
<bbNG:pageTitleBar title="Leaderboard Configuration"></bbNG:pageTitleBar>
</bbNG:pageHeader>
<!-- Body Content: Plotbands & Color Picker -->
	<bbNG:form action="leaderboard_save.jsp" method="post" onsubmit="javascript:history.go(-1)">
		<bbNG:dataCollection>
			<bbNG:step title="Plotbands Configuration">
				<bbNG:dataElement label="Level Values" labelFor="plotbands_config">
					<!-- bbNG:textbox label="plotbands_config" name="description" text="" isMathML="false" format="PLAIN_TEXT" /-->
					<bbNG:textElement name="plotbands_config" value=""/>
				</bbNG:dataElement>
				<bbNG:dataElement label="Plotbands Color">
					<bbNG:colorPicker name="color" />
				</bbNG:dataElement>
			</bbNG:step>
			<bbNG:stepSubmit />
		</bbNG:dataCollection>
	</bbNG:form>
</bbNG:modulePage>