<cfcomponent displayname="page" accessors="true">

	<cfproperty name="qa" type="array" />
	<cfproperty name="fuse" type="string" getter="true" default="default" />
	<cfproperty name="view" type="string" getter="true" default="default" />
	<cfproperty name="template" type="string" getter="true" default="default"  />
	<cfproperty name="title" type="string" default="" />
	<cfproperty name="description" type="string" default="" />
	<cfproperty name="keywords" type="string" default="" />
	<cfproperty name="headers" type="string" default="" />
	<cfproperty name="content" type="string" default="" />
	
	<cfproperty name="footerState" type="boolean" default="true" />
	
	
	<cffunction name="init" output="true">
		<cfscript>
			// init vars
			variables.title = "";
			variables.fuse = "default";
			variables.template = "default";
			variables.qa = ArrayNew(1);
			variables.footerState = true;
			
			// init the query array
			for(i=1;i<10;i+=1) variables.qa[i] = "";
			
			if(IsDefined("cgi.path_info") AND len(cgi.path_info))
		   		{
				var i = 1;
		   		var lastKey = "";
		   		var value = "";
				// create local array
		   		variables.qa = ListToArray(cgi.path_info,"/");
				// first index is always the fuse name
		   		variables.fuse = variables.qa[1];
				// loop remaining field/value pairs
			   	for(i=1; i LTE listLen(cgi.path_info, "/"); i+=1) 
					{
					value = listGetAt(cgi.path_info, i, "/");
					if(!i MOD 2) url[lastKey] = value;
					else lastKey = value;
					}
				//check for dangler
				if((i-1) MOD 2 EQ 1) url[lastKey] = "";
				// init the first 10
				for(; i LTE 10 ; i+=1) variables.qa[i] = "";
				}
			else
				{
				// set defaults if there's no query string on the URL
				//variables.qa = ArrayNew(1);
				variables.qa[1] = variables.fuse;
				}
			return(this);	
		</cfscript>
	</cffunction>
	
	<cffunction name="render" output="true">
		
		<!--- controller --->
		<cfsavecontent variable="discard_this_output">
			<cfif FileExists(ExpandPath("/controllers/#getFuse()#.cfm"))>
				<cfinclude template="/controllers/#getFuse()#.cfm" />
			<cfelse>
				<cfinclude template="/controllers/default.cfm" /> 
			</cfif>
		</cfsavecontent>

		<!--- view --->
		<cfsavecontent variable="page_content">
			<cfif FileExists(ExpandPath("/views/#getView()#.cfm"))>
				<cfinclude template="/views/#getView()#.cfm" />
			<cfelse>
				<cfinclude template="/views/default.cfm" /> 
			</cfif>
		</cfsavecontent>
		
		<cfset setContent(page_content) />
		
		<!--- template --->
		<cfif FileExists(ExpandPath("/templates/#getTemplate()#.cfm"))>
			<cfinclude template="/templates/#getTemplate()#.cfm" />
		<cfelse>
			<cfinclude template="/templates/default.cfm" />
		</cfif>
	</cffunction>
	
</cfcomponent>



