<cfcomponent output="true" >
	
	<cffunction name="OnApplicationStart" access="public" returntype="boolean" output="false" hint="Fires when the application is first created.">
		<cfset application.arse = "arse" />
		<cfset application.dsn = this.fission.dsn />
		<cfreturn true />
	</cffunction>
 
	<cffunction name="OnSessionStart" access="public" returntype="void" output="false" hint="Fires when the session is first created.">
		<cfset session.user = new co.ftg.fission.user() />
		<cfreturn />
	</cffunction>

	<cffunction name="OnRequestStart" access="public" returntype="boolean" output="false" hint="Fires at first part of page processing.">
		<cfreturn true />
	</cffunction>
	
	<cffunction name="OnRequest" access="public" returntype="void" output="true" hint="Fires after pre page processing is complete.">
		<cfargument name="TargetPage" type="string" required="true" />
		<cfif TargetPage EQ "/index.cfm">
			<cfscript>
			request.page = new co.ftg.fission.page();
			request.page.render();
			</cfscript>
		<cfelse>
			<cfinclude template="#TargetPage#" />
		</cfif>
	</cffunction>
	
	<cffunction name="OnRequestEnd" access="public" returntype="void" output="true" hint="Fires after the page processing is complete.">
		<cfreturn />
	</cffunction>

</cfcomponent>