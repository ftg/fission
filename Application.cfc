<cfcomponent displayname="Fission Application" extends="co.ftg.fission.application" ><!--- --->
	<cfset application.name = "app name" />
	
	<cfset request.domain_local = "app.local" />
	<cfset request.domain_stage = "stage.app.com" />
	<cfset request.domain_live = "www.app.com" />
	
	<cfset request.default_cache = CreateTimeSpan( 0, 1, 0, 0 ) /><!--- 1 hour --->
	
    <!--- Define the page request properties --->
	<cfsetting requesttimeout="60" showdebugoutput="true" enablecfoutputonly="false" />
    
    <!--- domain based DSN --->
	<cfif cgi.server_name EQ request.domain_local>
		<cfset request.dsn = "dev_database" />
	<cfelseif cgi.server_name EQ request.domain_stage>
		<cfset request.dsn = "stage_database" />
	<cfelseif cgi.server_name EQ request.domain_live>
		<cfset request.dsn = "live_database" />
	<cfelse>
		<cfset request.dsn = "" />
	</cfif>
	
	<!--- Set up the application. --->
	<cfset application.dsn = request.dsn />
	<cfset this.fission.dsn = request.dsn />
	<cfset this.name = application.name />
	<cfset this.ApplicationTimeout = request.default_cache />
	<cfset this.SessionManagement = true />
	<cfset this.SetClientCookies = true />
	<cfset this.SetDomainCookies = true />
		
	<cffunction name="onSessionStart" returnType="void"> 
		
	</cffunction>
	
</cfcomponent>
