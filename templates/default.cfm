<!doctype html>
<html>
<head>
	<meta charset="utf-8"/>
	<title><cfoutput>#request.page.getTitle()#</cfoutput></title>
	<meta name="description" content="<cfoutput>#request.page.getDescription()#</cfoutput>" /> 
	<cfoutput>#request.page.getHeaders()#</cfoutput>
</head>

<body class="view_<cfoutput>#request.page.getView()#</cfoutput>">

	<!-- START: View -->
	<cfoutput>#request.page.getContent()#</cfoutput>		
	<!-- END: View -->

</body>
</html>
