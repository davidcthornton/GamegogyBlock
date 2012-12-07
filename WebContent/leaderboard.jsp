<!--
	Gamegogy Leaderboard 1.1
    Copyright (C) 2012  David Thornton

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
-->

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
<bbData:context id="ctx">  <!-- to allow access to the session variables -->
<bbNG:includedPage>
<%

	//create a student class to hold their grades and other information
	final class Student implements Comparable<Student> {
	    public Double score;
	    public String firstName;
	    public String lastName;
	    
	    public Student(String firstName, String lastName, Double score) {
	        this.score = score;
	        this.firstName = firstName;
	        this.lastName = lastName;
	    }
	    
	    public int compareTo(Student s) {
	    	if (this.score > s.score) {
	    		return 1;
	    	}
	    	else if (this.score < s.score) {
	    		return -1;
	    	}
	    	else { return 0; }	    	
	    }
	} //end of class Student
	
	// get the current user
	User sessionUser = ctx.getUser();
	Id courseID = ctx.getCourseId();		
	String sessionUserRole = ctx.getCourseMembership().getRoleAsString();	
	String sessionUserID = sessionUser.getId().toString();	
	
	// use the GradebookManager to get the gradebook data
	GradebookManager gm = GradebookManagerFactory.getInstanceWithoutSecurityCheck();
	BookData bookData = gm.getBookData(new BookDataRequest(courseID));
	List<GradableItem> lgm = gm.getGradebookItems(courseID);
	// it is necessary to execute these two methods to obtain calculated students and extended grade data
	bookData.addParentReferences();
	bookData.runCumulativeGrading();
	// get a list of all the students in the class
	List <CourseMembership> cmlist = CourseMembershipDbLoader.Default.getInstance().loadByCourseIdAndRole(courseID, CourseMembership.Role.STUDENT, null, true);
	Iterator<CourseMembership> i = cmlist.iterator();
	List<Student> students = new ArrayList<Student>();
	
	// instructors will see student names
	boolean isUserAnInstructor = false;
	if (sessionUserRole.trim().toLowerCase().equals("instructor")) {
		isUserAnInstructor = true;
	}	
	Double scoreToHighlight = -1.0;
	int index = 0;
	
	while (i.hasNext()) {	
		CourseMembership cm = (CourseMembership) i.next();
		String currentUserID = cm.getUserId().toString();
		
		for (int x = 0; x < lgm.size(); x++){			
			GradableItem gi = (GradableItem) lgm.get(x);					
			GradeWithAttemptScore gwas2 = bookData.get(cm.getId(), gi.getId());
			Double currScore = 0.0;	
			
			if(gwas2 != null && !gwas2.isNullGrade()) {
				currScore = gwas2.getScoreValue();	 
			}						
			if (gi.getTitle().trim().toLowerCase().equalsIgnoreCase("total")) {
				if (sessionUserID.equals(currentUserID)) {
					scoreToHighlight = currScore;
				}
				students.add(new Student(cm.getUser().getGivenName(), cm.getUser().getFamilyName(), currScore));
			}		
		}
		index = index + 1;
	}
	Collections.sort(students);
	Collections.reverse(students);
	
	String jQueryPath = PlugInUtil.getUri("dt", "leaderboardblock11", "js/jqueryNoConflict.js");
	String highChartsPath = PlugInUtil.getUri("dt", "leaderboardblock11", "js/highcharts.js");
	String daveTestPath = PlugInUtil.getUri("dt", "leaderboardblock11", "js/daveTest.js");	
%>		

	<!-- this attach pleases chrome small and large -->	 
	<script type="text/javascript" id="daveTestID" src="<%=daveTestPath%>"></script>
	<script type="text/javascript" src="<%=jQueryPath%>"></script>
	<script type="text/javascript" src="<%=highChartsPath%>"></script>
	
	<!-- this attach pleases chrome small only -->
	<bbNG:jsFile href="<%=daveTestPath%>"/>
	<bbNG:jsFile href="<%=jQueryPath%>"/>
	<bbNG:jsFile href="<%=highChartsPath%>"/>
		
	<script type="text/javascript"> 
		var g = document.createElement('script');
		var t = document.getElementById('daveTestID');
		var s = document.getElementsByTagName('script')[0];
		console.log(t.src.text);
		g.text = "alert(\"hi\");"
		s.parentNode.insertBefore(g, s);
	</script>
	
		
	<script type="text/javascript">	
		// loading this way pleases firefox large (or does it?)		
		var script = document.createElement("script");
	    script.type = "text/javascript";
	    script.src = "<%=daveTestPath%>";
	    document.body.appendChild(script);
		
		script = document.createElement("script");
	    script.type = "text/javascript";
	    script.src = "<%=jQueryPath%>";
	    document.body.appendChild(script);
		
		script = document.createElement("script");
	    script.type = "text/javascript";
	    script.src = "<%=highChartsPath%>";
	    document.body.appendChild(script);
	    
		//this line is THE FIX for the prototype/jQuery conflict 
	 	dave = jQuery.noConflict();  //moving this out of the jquery .js pleases firefox large (or does it?)		
		//alert(daveTestVariable);
		
		window.onload = function() { 
			//alert("onload");
		}
	</script>
		
			
		<script type="text/javascript">		
			dave(document).ready(function() {
				
				//alert("jquery ready event");
				//console.log("GOING, AND DAVE SAYS " + daveTestVariable);
				var gamegogyLeaderboardChart;			
				
				var seriesValues = [
   				<%	
   					boolean alreadyHighlighted = false;
   					for (int x = 0; x < students.size(); x++){
   						Double score = (Double) students.get(x).score;
   						if (score == scoreToHighlight && !alreadyHighlighted) {
   							alreadyHighlighted = true;
   							out.print("{dataLabels: { enabled: true, style: {fontWeight: 'bold'} }, y:  " + score.toString() + ", color: '#44aa22'}");
   						}
   						else {
   							out.print(score.toString());
   						}
   						if (x < students.size() -1) { out.print(","); }
   						else { out.print("];"); }
   					}
   				%>
   				
   				var studentNames = [
  				<%	
  					if (isUserAnInstructor) {
  						for (int x = 0; x < students.size(); x++){
	  						String firstName = (String) students.get(x).firstName;
	  						String lastName = (String) students.get(x).lastName;
	  						out.print('"' + firstName.substring(0, 1) + ' ' + lastName + '"');   						
	  						if (x < students.size() -1) { out.print(","); }
	  						else { out.print("];"); }
	  					}
  					}
  				
  					else {
  						// this is a remote kludge
  						out.print("1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50];");
  					}
  				%>
		
				
  				gamegogyLeaderboardChart = new Highcharts.Chart({
					chart: {
						renderTo: 'leaderboardBlockChartContainer',
						type: 'bar'
					},
                    plotOptions: {
                        series: {
							pointPadding: 0,
							groupPadding: 0.1,
                            borderWidth: 0,
                            borderColor: 'gray',
                            shadow: false
                        }
                    },
					legend: {  enabled: false  },  
					title: {
						text: null
					},						
					xAxis: {						
						categories: studentNames,
						title: {
							text: null
						}
					},
					yAxis: {
						title: {
							text: null
						},
						gridLineWidth: 0,
						labels: {
							enabled: false
						},
						offset: 20,
						plotBands: [
							{ 
								color: '#ffffff',
								from: 0,
								to: 100,
								label: {
									text: '',
									verticalAlign: "bottom",
									style: {
										color: '#666666'										
									}
								}
							},
							{ 
								color: '#eeeeee',
								from: 100,
								to: 300,
								label: {
									text: 'Level 2',
									verticalAlign: "bottom",
									style: {
										color: '#666666'										
									}									
								}
							},
							{ 
								color: '#dddddd',
								from: 300,
								to: 600,
								label: {
									text: 'Level 3',               
									verticalAlign: "bottom",
									style: {
										color: '#666666'										
									}									
								}
							},
							{ 
								color: '#cccccc',
								from: 600,
								to: 1000,
								label: {
									text: 'Level 4',               
									verticalAlign: "bottom",
									style: {
										color: '#666666'										
									}									
								}
							},
							{ 
								color: '#bbbbbb',
								from: 1000,
								to: 1500,
								label: {
									text: 'Level 5',               
									verticalAlign: "bottom",
									style: {
										color: '#666666'										
									}									
								}
							}							
						]
					
					},
					tooltip: {
						formatter: function() {
							var level = 1;
							// literals here!
							if (this.y < 100) { level = 1; }
							else if (this.y < 300) { level = 2; }
							else if (this.y < 600) { level = 3; }
							else if (this.y < 1000) { level = 4; }
							else { level = 5; }
							return this.y;
						}
					},
					
					credits: {
						enabled: false
					},
					series: [{
						name: 'XP',
						data: seriesValues
					}]
				}); //end of chart			
			}); // end of ready function						  		
		</script>
	
	<div id="leaderboardBlockChartContainer"></div>
				
	
</bbNG:includedPage>
</bbData:context>