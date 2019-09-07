<%
var qqstr=Request.ServerVariables("QUERY_STRING")
var urlall="http://"+Request.ServerVariables("SERVER_NAME")+Request.ServerVariables("URL")
if (qqstr!="") {urlall=urlall+"?"+qqstr}
Session("urlstat")=urlall
%>