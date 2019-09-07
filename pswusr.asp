<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\getform.inc" -->
<!-- #include file="inc\err.inc" -->
<!-- #include file="inc\sql.inc" -->
<!-- #include file="inc\creaters.inc" -->

<%
var fio=""
var usr=parseInt(Request("usr"))
var ShowForm=true
var ErrorMsg=""
var sql=""
var valname=""
var valname1=""

if ((Session("is_adm_mem")!=1)&&(Session("id_mem")!=usr)){
Session("backurl")="pswusr.asp?usr="+usr
Response.Redirect("login.asp")}

Records.Source="Select * from USERS where ID="+usr
Records.Open()
if (Records.EOF){Response.Redirect("area.asp")}
fio=String(Records("FIO").Value)
Records.Close()

isFirst=String(Request.Form("Submit"))=="undefined"

if(!isFirst){
	valname=TextFormData(Request.Form("valname"),"")
	valname1=TextFormData(Request.Form("valname1"),"")
	if (valname!=valname1) {ErrorMsg+="Пароль не подтвержден или подтвержден с ошибкой.<br>"}
	if (String(valname).length<5) {ErrorMsg+="Пароль не может быть менее 5-и символов.<br>"}
	
	if (ErrorMsg=="") {
		sql=usrpsw
		sql=sql.replace("%ID",usr)
		sql=sql.replace("%PS",valname)
		//Connect.BeginTrans()
		//try{
		//	Connect.Execute(sql)
		//}
		//catch(e){
		//	Connect.RollbackTrans()
		//	ErrorMsg+=ListAdoErrors()
		//}
		if (ErrorMsg==""){
		//	Connect.CommitTrans()
			ShowForm=false
		}
	}
}
%>

<html>
<head>
<title>Изменение пароля доступа <%=fio%></title> <meta http-equiv="Content-Type" content="text/html; charset=windows-1251"> 
<LINK REL="stylesheet" HREF="/style.css" TYPE="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000" LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0">
<TABLE WIDTH="100%" BORDER="1" CELLSPACING="0" CELLPADDING="0" BORDERCOLOR="#FFFFFF"> 
<TR> <TD BGCOLOR="#CCCCCC" BORDERCOLOR="#333333"> <P><FONT FACE="Arial, Helvetica, sans-serif"><a href="index.asp">На 
главную страницу</A> | <A HREF="area.asp">КАБИНЕТ Администратора</A> </FONT></P></TD></TR> 
</TABLE><H1 align="center"><b>Изменение пароля доступа.</b> <BR>Пользователь: 
<b><font color="#000099"><%=fio%></font></b></H1><p>&nbsp;</p><%if(ErrorMsg!=""){%> 
<center> <p> <font color="#FF3300" size="2"><b>Ошибка!</b></font> <br><%=ErrorMsg%></p></center><%}%> 
<p align="center"><a href="area.asp">Кабинет</a> &nbsp;&nbsp;&nbsp;<a href="index.asp">Домашняя 
  страница</a></p>
<p align="center"><font color="#FF3333">Изменение пароля заблокировано в демо-версии 
  и показывает лишь принцип работы данной формы не меняя при этом пароля.</font></p>
<%if (ShowForm) {%> <form name="form1" method="post" action="pswusr.asp"> 
<div align="center"> <input type="hidden" name="usr" value="<%=usr%>"> <table width="70%" border="1" bordercolor="#333333"> 
<tr bordercolor="#999999" bgcolor="#CCCCCC"> <td width="50%"> <div align="center"><P><b><font color="#000099">Параметры:</font></b></P></div></td><td> 
<div align="center"><P><b><font color="#000099">Значения:</font></b></P></div></td></tr> 
<tr bordercolor="#999999"> <td width="50%"> <div align="right"><P>Введите новый 
пароль для администрирования:&nbsp;&nbsp;</P></div></td><td><P>&nbsp;&nbsp;&nbsp; 
<input type="password" name="valname" maxlength="20" size="20"> </P></td></tr> 
<tr bordercolor="#999999"> <td width="50%"> <div align="right"><P>Повторите ввод 
нового пароля:&nbsp;&nbsp;</P></div></td><td><P>&nbsp;&nbsp;&nbsp; <input type="password" name="valname1" maxlength="20" size="20"> 
</P></td></tr> </table><input type="submit" name="Submit" value="Сохранить"> </div></form><%} else {%> 
<p>&nbsp; </p><center> <H1><font color="#3333FF">Пароль изменен!</font></H1>
  <p> 
    <%}%>
  </p>
  <p>&nbsp;</p>
  <p align="center"></p>
  </center>
</body>
</html>
