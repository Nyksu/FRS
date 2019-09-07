<%@LANGUAGE="JScript"%>
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\getform.inc" -->
<!-- #include file="inc\err.inc" -->
<!-- #include file="inc\path.inc" -->
<!-- #include file="inc\Creaters.inc" -->
<!-- #include file="inc\url.inc" -->

<%
// тут запишем код СМИ... Не забыть изменить его в других сайтах!!
var smi_id=33
// +++  smi_id - код СМИ в таблице SMI !!

var pid=parseInt(Request("pid"))
if (isNaN(pid)) {Response.Redirect("index.asp")}

var hid=0
var sminame=""
var tit=""
var hdd=0
var nm=""
var hiname=""
var period=0
var path=""
var hadr=""
var pname=""
var pdat=""
var autor=""
var news=""
var digest=""
var imgname=""
var imgLname=""
var imgRname=""
var filnam=""
var fs= new ActiveXObject("Scripting.FileSystemObject")
var ts=""
var sos=""
var ishtml=0
var isnews=1
var lgok=false
var usok=false
var bnm=""
var bpos=""
var bid=0

var tps=parseInt(Request("tps"))
var sens=parseInt(Request("sensation"))
if (isNaN(sens)) {sens=0}
var sch=TextFormData(Request("sch"),"")
if (isNaN(tps)) {tps=1}
var wrds=parseInt(Request("wrds"))
if (isNaN(wrds)) {wrds=0}
var pg=parseInt(Request("pg"))
if (isNaN(pg)) {pg=0}

if (String(Session("id_mem"))=="undefined") {
	if (Session("tip_mem_pub")<3) {usok=true}
	if (Session("tip_mem_pub")<4) {lgok=true}
} else {
	if ((Session("is_adm_mem")!=1) && (Session("is_host")!=1)) {
		sql="Select * from smi where users_id="+Session("id_mem")+"and id="+smi_id
		Records.Source=sql
		Records.Open()
		if (!Records.EOF) {
			usok=true
			lgok=true
		}
		Records.Close()
	} else {
		usok=true
		lgok=true
	}
}


Records.Source="Select t1.* from publication t1, heading t2 where t1.state=1 and t1.id="+pid+" and t1.heading_id=t2.id and t2.smi_id="+smi_id
Records.Open()
if (Records.EOF) {
	Records.Close()
	Response.Redirect("index.asp")
}
hid=Records("heading_id").Value
pname=String(Records("NAME").Value)
digest=TextFormData(Records("DIGEST").Value,"")
pdat=Records("PUBLIC_DATE").Value
autor=TextFormData(Records("AUTOR").Value,"")
ishtml=TextFormData(Records("ISHTML").Value,"0")
Records.Close()

Records.Source="Select * from smi where  id="+smi_id
Records.Open()
sminame=String(Records("NAME").Value)
Records.Close()

tit=sminame

hdd=hid
while (hdd>0) {
	Records.Source="Select * from heading where id="+hdd
	Records.Open()
	nm=String(Records("NAME").Value)
	isnews=Records("ISNEWS").Value
	hadr=TextFormData(Records("URL").Value,"pubheading.asp")
	if (hdd==hid) {
		hiname=String(Records("NAME").Value)
		period=Records("PERIOD").Value
	}
	path="<a href=\""+hadr+"?hid="+hdd+"\"><font color=\"#FFFFFF\">"+nm+"</font></a> > "+path
	hdd=Records("HI_ID").Value
	Records.Close()
}

var ddt = new Date()
var dt=""
var str=""
var sumdat=Server.CreateObject("datesum.DateSummer")
if ( isnews ) {
str=String(ddt.getMonth()+1)
if (str.length==1) {str="0"+str}
dt="."+str+"."+ddt.getYear()
str=String(ddt.getDate())
if (str.length==1) {str="0"+str}
dt=str+dt
dt=sumdat.SummToDate(dt,"-"+period)
if (sumdat.DateComparing(dt,pdat) > 0) {sos="В архиве"} else {sos="В публикации"}
}

path="<a href=\"index.asp\"><font color=\"#FFFFFF\">"+sminame+"</font></a> > "+path
tit+=" | "+hiname

filnam=PubFilePath+pid+".pub"
if (!fs.FileExists(filnam)) { filnam="" }

if (filnam != "") {
	ts= fs.OpenTextFile(filnam)
	if (ishtml==0) {
	while (!ts.AtEndOfStream){
		news+="<p style='text-align:justify'>"+ts.ReadLine()+"</p>"
	}
	} else {news=ts.ReadAll()}
	ts.Close()
}

imgname=PubImgPath+pid+".gif"
if (!fs.FileExists(PubFilePath+pid+".gif")) { imgname="" }
if (imgname=="") {
	imgname=PubImgPath+pid+".jpg"
	if (!fs.FileExists(PubFilePath+pid+".jpg")) { imgname="" }
}

imgLname=PubImgPath+"l"+pid+".gif"
if (!fs.FileExists(PubFilePath+"l"+pid+".gif")) { imgLname="" }
if (imgLname=="") {
	imgLname=PubImgPath+"l"+pid+".jpg"
	if (!fs.FileExists(PubFilePath+"l"+pid+".jpg")) { imgLname="" }
}

imgRname=PubImgPath+"r"+pid+".gif"
if (!fs.FileExists(PubFilePath+"r"+pid+".gif")) { imgRname="" }
if (imgRname=="") {
	imgRname=PubImgPath+"r"+pid+".jpg"
	if (!fs.FileExists(PubFilePath+"r"+pid+".jpg")) { imgRname="" }
}

%>

<html>
<head>
<title><%=pname%> - <%=tit%> -  г. Тюмень</title>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
<link rel="stylesheet" href="style.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000" topmargin="0" leftmargin="35" marginwidth="35">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td align="left"> 
      <h1><font size="4"><%=sminame%></font></h1>
    </td>
    <td width="100" align="center"> 
      <p>г. Тюмень</p>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#666666">
  <tr bgcolor="#CCCCCC"> 
    <td height="16" width="50%"> 
      <p><%=path%> </p>
    </td>
    <td height="16" align="right"> 
      <p><%=tit%></p>
    </td>
    <form name="form1" method="post" action="search.asp">
    </form>
  </tr>
</table>


<table width="100%" border="0" cellpadding="0" align="center" cellspacing="0" bgcolor="#E1F4FF" height="300">
  <tr> 
    <td valign="top" bgcolor="#FFFFFF"> 
      <table width="98%" border="0" bordercolor="#FFFFFF" align="center" cellspacing="0" class="base_text">
        <tr valign="top" bordercolor="#FFFFFF"> 
          <td bordercolor="#FFFFFF"> 
            <h1 align="center"><font color="#000000" size="4"><%=pname%></font></h1>
            <p align="center"><font size="3"><%=digest%></font></p>
            <p align="right"><b>&copy; <%=pdat%>&nbsp; <%=autor%> </b></p>
          </td>
        </tr>
        <tr valign="top" bordercolor="#FFFFFF"> 
          <td height="55"> 
            <p> 
              <%if (imgLname != "") {%>
              <img src="<%=imgLname%>" align="left" border="1" > 
              <%}else{%>
              &nbsp; 
              <%}%>
              <font face="Times New Roman, Times, serif"><%=news%> </font></p>
          </td>
        </tr>
      </table>
      <table width="100%" border="0" align="center" cellspacing="0">
        <tr bordercolor="#CCCCCC"> 
          <td valign="top" height="40"> 
            <div align="center"> 
              <%if (imgRname != "") {%>
              <img src="<%=imgRname%>" border="1" > 
              <%}else{%>
              &nbsp; 
              <%}%>
            </div>
          </td>
        </tr>
      </table>
      <table border="0" cellspacing="2" cellpadding="2" width="100%">
        <tr> 

        </tr>
      </table>
      
      
    </td>
  </tr>
</table>
<hr size="1">
<div align="center"></div>
</body>
</html>
