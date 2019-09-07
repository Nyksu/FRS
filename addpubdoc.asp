<%@LANGUAGE="JScript"%>
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\getform.inc" -->
<!-- #include file="inc\err.inc" -->
<!-- #include file="inc\path.inc" -->
<!-- #include file="inc\sql.inc" -->

<%
var pid=Request("pid")
var hd=Request("hd")

// тут запишем код СМИ... Не забыть изменить его в других сайтах!!
var smi_id=33
// +++  smi_id - код СМИ в таблице SMI !!

var hid=0
var hdd=0
var sql=""
var name=""
var articul=""
var srname=""
var sminame=""
var pname=""
var nm=""
var path=""
var imgname=""
var ext=""
var size=0
var ErrorMsg=""
var posit=0
var usok=false

if (isNaN(parseInt(pid))) {
	if (Request.ServerVariables("REQUEST_METHOD")=="POST") {
	   updown = Server.CreateObject("ANUPLOAD.OBJ")
		pid=updown.Form("pid")
		hd=updown.Form("hd")
		if (!isNaN(parseInt(pid))) {
		try {
			updown.Delete(PubFilePath+pid+".rtf")
			updown.SavePath = PubFilePath
			size=parseInt(updown.GetSize("file"))
			ext=updown.GetExtension("file").toUpperCase()
			if(ext!="RTF"){throw "Принимаются только RTF файлы."}
			if (size>1024000){throw "Не более 1000 kB."}
			if (size==0){throw "Нет файла."}
			updown.SaveAs("file",PubFilePath+pid+"."+ext)
			Response.Redirect("pubdheading.asp?hid="+hd)
			}
    	catch(e){ErrorMsg+=String(e.message)=="undefined"?e:e.message}
		
		} else {Response.Redirect("index.asp")}
	}
	else {Response.Redirect("index.asp")}
}

Records.Source="Select t1.* from publication t1, heading t2 where t1.id="+pid+" and t1.heading_id=t2.id and t2.smi_id="+smi_id
Records.Open()
if (Records.EOF) {
	Records.Close()
	Response.Redirect("index.asp")
}
hid=Records("heading_id").Value
pname=String(Records("NAME").Value)
Records.Close()

if (String(Session("id_mem"))=="undefined") {
	if (String(Session("id_mem_pub"))=="undefined") {
		Session("backurl")="addpubdoc.asp?pid="+pid
		Response.Redirect("logpub.asp")
	}
	if (Session("tip_mem_pub")<4) {usok=true}
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

hdd=hid
while (hdd>0) {
	Records.Source="Select * from heading where id="+hdd
	Records.Open()
	nm=String(Records("NAME").Value)
	hadr=TextFormData(Records("URL").Value,"pubheading.asp")
	if (hdd==hid) {
		path=nm+" | "+path
		hiname=String(Records("NAME").Value)
		period=Records("PERIOD").Value
	}
	else {
		path="<a href=\""+hadr+"?hid="+hdd+"\">"+nm+"</a> | "+path
	}
	hdd=Records("HI_ID").Value
	Records.Close()
}

path="<a href=\"index.asp\">"+sminame+"</a> | "+path

%>


<html>
<head>
<title>Загрузка документа к публикации: <%=pname%></title> <meta http-equiv="Content-Type" content="text/html; charset=windows-1251"> 
<link rel="stylesheet" href="style.css" type="text/css"> 
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0">
<table width="100%" border="1" cellspacing="0" cellpadding="0">
  <tr bgcolor="#FFCC00"> 
    <td colspan="3" height="17" bgcolor="#CCCCCC" bordercolor="#CCCCCC"> 
      <p align="left"><%=path%>
        Публикация: <a href="newshow.asp?pid=<%=pid%>"> <%=pname%></a></p>
    </td>
  </tr>
</table>
<%if(ErrorMsg!=""){%>
<center>
  <p> <font color="#FF3300" size="2"><b>Ошибка!</b></font> <br>
    <%=ErrorMsg%></p>
</center>
<%}%>
<form name="form1" method="post" action="addpubdoc.asp" enctype="multipart/form-data">
  <h1> 
    <input type="hidden" name="pid" value="<% =pid %>">
    <input type="hidden" name="hd" value="<% =hd %>">
  </h1>
  <h1 class="title01" align="center"> <b>Загрузка файла публикации: </b></h1>
  <p align="center"><font size="4" color="#CC3300"><b><%=pname%></b></font></p>
  <div align="center"> 
    <p>файл RTF до 1000 килобайт</p>
  </div>
  <div align="center"> 
    <table width="500" border="2" bordercolor="#FFFFFF">
      <tr> 
        <td bordercolor="#333333" bgcolor="#E6E6E6"> 
          <div align="center"> 
            <p><b>Выбирите файл в формате RTF на своем компьютере для загрузки 
              на сервер:</b></p>
          </div>
        </td>
      </tr>
      <tr> 
        <td bordercolor="#333333"> 
          <div align="left"> 
            <p>2. 
              <input type="file" name="file" size="40">
            </p>
          </div>
        </td>
      </tr>
    </table>
  </div>
  <p align="center"> 
    <input type="submit" name="Submit" value="Сохранить">
  </p>
</form>
<p align="center"><font size="1">Для удаления документа нажмите &quot;Сохранить&quot; 
  без выбора файла </font></p>
<hr width="500">
<p align="center">&nbsp;</p>
<p align="center"><font size="2"><a href="newshow.asp?pid=<%=pid%>">Вернуться 
  к публикации</a></font></p>
</body>
</html>
