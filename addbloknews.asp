<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\getform.inc" -->
<!-- #include file="inc\err.inc" -->
<!-- #include file="inc\next_id.inc" -->
<!-- #include file="inc\Creaters.inc" -->
<!-- #include file="inc\sql.inc" -->

<%
var usok=false
var sql=""
// тут запишем код СМИ... Не забыть изменить его в других сайтах!!
var smi_id=33
// +++  smi_id - код СМИ в таблице SMI !!

var sminame=""
var ErrorMsg=""
var ShowForm=true
var name=""
var subj=""
var id=0

if (String(Session("id_mem"))=="undefined") {
	if (String(Session("id_mem_pub"))=="undefined") {
		Session("backurl")="addbloknews.asp"
		Response.Redirect("logpub.asp")
	}
	if (Session("tip_mem_pub")==1) {usok=true}
} else {
	if ((Session("is_adm_mem")!=1) && (Session("is_host")!=1)) {
		sql="Select * from smi where users_id="+Session("id_mem")+"and id="+smi_id
		Records.Source=sql
		Records.Open()
		if (!Records.EOF) {
			usok=true
		}
		Records.Close()
	} else {
		usok=true
	}
}

if (!usok) {Response.Redirect("index.asp")}

Records.Source="Select * from smi where  id="+smi_id
Records.Open()
sminame=String(Records("NAME").Value)
Records.Close()

isFirst=String(Request.Form("Submit"))=="undefined"

if (!isFirst) {
	name=TextFormData(Request.Form("name"),"")
	subj=TextFormData(Request.Form("subj"),"")
	
	if (subj.length<3) {ErrorMsg+="Слишком короткое наименование блока.<br>"}
	
	if (ErrorMsg=="") {
		id=NextID("PUBLOCKID")
		sql=insblock
		sql=sql.replace("%ID",id)
		sql=sql.replace("%NAM",name)
		sql=sql.replace("%SMI",smi_id)
		sql=sql.replace("%SUBJ",subj)
		Connect.BeginTrans()
		try{
			Connect.Execute(sql)
		}
		catch(e){
			Connect.RollbackTrans()
			ErrorMsg+=ListAdoErrors()
		}
		if (ErrorMsg==""){
		  Connect.CommitTrans()
		  ShowForm=false
		}
	}
}

%>

<html>
<head>
<title>Добавление блока новостей (<%=sminame%>)</title> <meta http-equiv="Content-Type" content="text/html; charset=windows-1251"> 
<link rel="stylesheet" href="style.css" type="text/css"> 
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0">
<table width="100%" border="1" cellspacing="1" cellpadding="0" bgcolor="#CCCCCC" bordercolor="#000000">
  <tr>
    <td bordercolor="#CCCCCC">
      <p><a href="area.asp"><b>Кабинет администратора</b></a> | <a href="index.asp">Редактировать 
        сайт</a> | <a href="bloknews.asp">Информационные блоки</a> </p>
    </td>
  </tr>
</table>
<%if(ErrorMsg!=""){%>
<center>
<p> <font color="#FF3300" size="2"><b>Ошибка!</b></font> <br><%=ErrorMsg%></p>
</center>
<%}%> 

<%if(ShowForm){%>
<h1 align="center"><b><font size="3">Здесь можно добавить новый блок новостей. 
  </font><font size="3" color="#0000CC"><%=sminame%></font></b></h1>
<form name="form1" method="post" action="addbloknews.asp">
  <p align="center">Для добавления информационного блока, пожалуйста, заполните 
    поля формы: </p>
  <table width="780" border="1" bordercolor="#FFFFFF" align="center">
    <tr> 
      <td width="380" bgcolor="#CCCCCC" bordercolor="#333333"> 
        <div align="center"> 
          <p><b>Параметры:</b></p>
        </div>
      </td>
      <td width="10"> 
        <p>&nbsp;</p>
      </td>
      <td bgcolor="#CCCCCC" width="582" bordercolor="#333333"> 
        <div align="center"> 
          <p><b>Значения:</b></p>
        </div>
      </td>
    </tr>
    <tr bordercolor="#333333"> 
      <td width="380" height="14" valign="middle"> 
        <div align="right"><font size="2" color="#FF0000">Видимое посетителям 
          наименование блока:</font><font size="2">&nbsp;&nbsp;</font></div>
      </td>
      <td width="10" height="14" bordercolor="#FFFFFF"> 
        <div align="center">-</div>
      </td>
      <td width="582" height="14" valign="top"> 
        <input type="text" name="subj" value="<%=isFirst?"":Request.Form("subj")%>" maxlength="50" size="50">
      </td>
    </tr>
    <tr bordercolor="#333333"> 
      <td width="380" valign="middle" height="18"> 
        <div align="right"><font size="2">Краткое описание, назначение:&nbsp;&nbsp;</font></div>
      </td>
      <td width="10" height="18" bordercolor="#FFFFFF"> 
        <div align="center">-</div>
      </td>
      <td width="582" valign="top" height="18"> <font size="2"> 
        <input type="text" name="name" value="<%=isFirst?"":Request.Form("name")%>" maxlength="100" size="50">
        </font></td>
    </tr>
  </table>
  <p align="center"><font color="#FF0000">Параметры выделенные красным цветом 
    обязательны к заполнению!</font></p>
  <p align="center"> 
    <input type="submit" name="Submit" value="Сохранить">
  </p>
</form>
<%} 
else 
{%>
<center>
  <h1><font color="#3333FF">Блок добавлен!</font></h1>
</center>
<%}%>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr bgcolor="#000000"> 
    <td width="300"> 
      <p>&nbsp;</p>
    </td>
    <td align="RIGHT">&nbsp;
    </td>
  </tr>
</table>
<p align="CENTER"><font size="1"><b>| <a href="index.asp"><font face="Arial, Helvetica, sans-serif" size="1"> 
  <b>На главную</b></font></a> | <a href="message.asp">Обратная связь</a> | <a href="company.asp">Реквизиты 
  компании</a> |</b></font></p>
<p align="center"><font size="1">&copy; 2002-2005 программирование <a href="http://www.rusintel.ru">Русинтел</a></font></p>
<hr size="1" noshade align="center" width="468">
<p align="center"> 
  <script language="JavaScript" src="http://vbn.tyumen.ru/cgi-bin/hints.cgi?vbn&rusintel">
</script>
</p>
<p align="center"> 
  <script language="javascript">
hotlog_js="1.0";
hotlog_r=""+Math.random()+"&s=48807&im=5&r="+escape(document.referrer)+"&pg="+
escape(window.location.href);
document.cookie="hotlog=1; path=/"; hotlog_r+="&c="+(document.cookie?"Y":"N");
</script>
  <script language="javascript1.1">
hotlog_js="1.1";hotlog_r+="&j="+(navigator.javaEnabled()?"Y":"N")</script>
  <script language="javascript1.2">
hotlog_js="1.2";
hotlog_r+="&wh="+screen.width+'x'+screen.height+"&px="+
(((navigator.appName.substring(0,3)=="Mic"))?
screen.colorDepth:screen.pixelDepth)</script>
  <script language="javascript1.3">hotlog_js="1.3"</script>
  <script language="javascript">hotlog_r+="&js="+hotlog_js;
document.write("<a href='http://click.hotlog.ru/?48807' target='_top'><img "+
" src='http://hit3.hotlog.ru/cgi-bin/hotlog/count?"+
hotlog_r+"&' border=0 width=1 height=1></a>")</script>
</p>
  </body>
</html>
