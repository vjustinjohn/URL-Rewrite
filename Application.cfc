<cfcomponent>
	
	<cfset This.name = "TestApp">
	<cfset This.Sessionmanagement=true>
	<cfset This.clientmanagement=false>
	<cfset This.setclientcookies=true>
	<cfset This.Sessiontimeout="#createtimespan(0,0,90,0)#">
	<cfset This.applicationtimeout="#createtimespan(0,0,120,0)#">

	<cffunction name="onApplicationStart">
	    <!--- Application settings  --->
		<cfset application.root_path = "" />
		<cfset application.root_path_secure = "" />
	
	</cffunction>
	
	<cffunction name="onSessionStart">
	 
	 
	</cffunction>
	
	<cffunction name="onRequestStart">
	    <cfset query_string_length=Len(CGI.REQUEST_URI)-Len(CGI.SCRIPT_NAME)>
	
		<cfif query_string_length gt 0>
		
			<cfset query_string=Right(CGI.REQUEST_URI, query_string_length)>

			<!--- How many items in "query_string? --->
			<cfset items=ListLen(query_string, "/")>
			
			<!--- Loop through list, pair of items at a time --->
			<cfloop from="1" to="#items#" step="2" index="i">
				<cfset paramname= ListGetAt(query_string, i, "/" )>
				<cfset paramname= replace(paramname, ' ', '', 'ALL')>
				<cfset paramname= replace(paramname, '-', '', 'ALL')>
				<cfset paramname= replace(paramname, '&', '', 'ALL')>
				<cfset paramname= replace(paramname, '.', '', 'ALL')>
				<cfset paramname= replace(paramname, ':', '', 'ALL')>
				<cfif isNumeric(left(paramname,1))>
		            <cfset paramname = "A" & paramname>
				</cfif>
				<cfif ListLen(query_string, "/") gte i+1 and paramname is not "">
					<!--- Save this URL parameter --->
					<cfparam name="URL.#paramname#" default="#ListGetAt(query_string, i+1, "/")#">
				</cfif>
			</cfloop>
		</cfif>
	</cffunction>
    
	<!--- <cffunction name="onError"> --->
       <!--- <cflocation url="#application.root_path#/index.cfm/method/404"> --->
    <!--- </cffunction> --->
	
</cfcomponent>