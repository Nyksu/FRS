<%
function CreateRecordSet(){
	var recs=Server.CreateObject("ADODB.Recordset")
	recs.ActiveConnection=Connect
	recs.CursorType = 3
	recs.CursorLocation = 3
	recs.LockType = 3
	return recs
}
%>