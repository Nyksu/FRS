<%@LANGUAGE="JScript"%>
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\getform.inc" -->
<!-- #include file="inc\err.inc" -->
<!-- #include file="inc\path.inc" -->
<!-- #include file="inc\Creaters.inc" -->

<%
// тут запишем код СМИ... Не забыть изменить его в других сайтах!!
var smi_id=33
// +++  smi_id - код СМИ в таблице SMI !!

var hid=parseInt(Request("hid"))
if (isNaN(hid)) {Response.Redirect("index.asp")}

var pg=parseInt(Request("pg"))
if (isNaN(pg)) {pg=0}

if (hid==0) {Response.Redirect("index.asp")}

var hname=""
var hiname=""
var url=""
var pid=0
var pname=""
var pdat=""
var autor=""
var digest=""
var sminame=""
var period=0
var pos=0
var lpag=0
var pp=0
var hdd=0
var path=""
var nm=""
var hadr=""
var imgname=""
var fs= new ActiveXObject("Scripting.FileSystemObject")
var nid=0
var name=""
var ndat=""
var nadr=""
var per=0
var kvopub=0
var isnews=1
var ishtml=0
var tpm=1000
var usok=false
var blokname=""

if (String(Session("id_mem"))=="undefined") {
	if (Session("tip_mem_pub")<3) {usok=true}
	tpm=Session("tip_mem_pub")
} else {
	if ((Session("is_adm_mem")!=1) && (Session("is_host")!=1)) {
		sql="Select * from smi where users_id="+Session("id_mem")+"and id="+smi_id
		Records.Source=sql
		Records.Open()
		if (!Records.EOF) {
			usok=true
			tpm=0
		}
		Records.Close()
	} else {
		usok=true
		tpm=0
	}
}

Records.Source="Select * from smi where  id="+smi_id
Records.Open()
sminame=String(Records("NAME").Value)
Records.Close()

tit=sminame

Records.Source="Select * from heading where id="+hid+" and smi_id="+smi_id
Records.Open()
if (Records.EOF) {
	Records.Close()
	Response.Redirect("index.asp")
}
isnews=Records("ISNEWS").Value
Records.Close()


hdd=hid
while (hdd>0) {
	Records.Source="Select * from heading where id="+hdd
	Records.Open()
	nm=String(Records("NAME").Value)
	hadr=TextFormData(Records("URL").Value,"pubheading.asp")
	if (hdd==hid) {
		path=nm+"   "+path
		hiname=String(Records("NAME").Value)
		period=Records("PERIOD").Value
		lpag=Records("PAGE_LENGTH").Value
	}
	else {
		path="<a href=\""+hadr+"?hid="+hdd+"\">"+nm+"</a> > "+path
	}
	hdd=Records("HI_ID").Value
	Records.Close()
}

path="<a href=\"index.asp\">"+sminame+"</a> > "+path
tit+=" | "+hiname

if (pg>0) {pp=pg*lpag}
%>

<html>
<head>
<title><%=tit%></title>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">

<link rel="stylesheet" href="style.css" type="text/css">
</head>

<body bgcolor="#F2EEE1" text="#000000" topmargin="0" leftmargin="0" marginwidth="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr bgcolor="#000000"> 
    <td width="300"> 
      <p><a href="http://www.rusintel.ru"><font color="#FFFFFF"><b><%=sminame%></b></font></a> 
        / <a href="index.asp"><b><font color="#FFFFFF"> </font></b></a></p>
    </td>
    <td align="RIGHT">&nbsp;
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr  bgcolor="#333333"> 
    <td valign="middle" width="500"> 
      <p><b><font color="#CCCCCC">&quot;<%=sminame%>&quot;</font></b></p>
    </td>
    <td  bgcolor="#333333" align="right"> &nbsp;
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr  bgcolor="#333333"> 
    <td valign="middle" width="500" bgcolor="#FFFFFF"> 
      <p>&nbsp;&nbsp;<%=path%> &gt; Архив</p>
    </td>
    <td bgcolor="#FFFFFF" align="right"> 
      <p><b><font color="#990000"><%=nm%></font></b></p>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="1"  bgcolor="#333333">
  <tr> 
    <td></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="12">
  <tr> 
    <td></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
  <tr bgcolor="#F2EEE1"> 
    <td valign="top" align="right" width="12">&nbsp;</td>
    <td valign="top" align="right" width="202"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="D92B2B">
        <tr align="center"> 
          <td colspan="5"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
              <tr> 
                <td align="center" class="dir_title" valign="middle"  bgcolor="#333333" width="23">&nbsp;</td>
                <td align="left" class="dir_title" valign="middle"  bgcolor="#333333"> 
                  <p><b><font color="#CCCCCC">Навигация</font></b></p>
                </td>
                <td width="21"  bgcolor="#333333">&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <table width="100%" border="1" cellspacing="0" cellpadding="5" class="base_text" bordercolor="#333333">
        <tr> 
          <td bgcolor="#FFFFFF" bordercolor="#FFFFFF"> 
            <li> <a class="globalnav" href="index.asp"> 
              <p><b>На главную</b></p>
              </a> 
              <%
isnews=1
Records.Source="Select * from heading where hi_id=0 and smi_id="+smi_id+" and isnews="+isnews+" order by name"
Records.Open()
while (!Records.EOF)
{
	hdd=String(Records("ID").Value)
	hname=String(Records("NAME").Value)
	per=Records("PERIOD").Value
	url=TextFormData(Records("URL").Value,"pubheading.asp")
	url+="?hid="+hdd
	Records.MoveNext()
%>
            <li> 
              <%if (hdd != hid){%>
              <a  class=globalnav href="<%=url%>"> 
              <%}else{%>
              <font class=globalnav color="#990000"> 
              <%}%>
              <p><b><%=hname%></b></p>
              <%if (hdd != hid){%>
              </font></a><font color="#990000"> 
              <%} else {%>
              </font> 
              <%}%>
              <%
} 
Records.Close()
%>
              <%
isnews=0
Records.Source="Select * from heading where hi_id=0 and smi_id="+smi_id+" and isnews="+isnews+" order by name"
Records.Open()
while (!Records.EOF)
{
	hdd=String(Records("ID").Value)
	hname=String(Records("NAME").Value)
	per=Records("PERIOD").Value
	url=TextFormData(Records("URL").Value,"pubheading.asp")
	url+="?hid="+hdd
	Records.MoveNext()
%>
            <li> 
              <%if (hdd != hid){%>
              <a  class=globalnav href="<%=url%>"> 
              <%}else{%>
              <font class=globalnav color="#990000"> 
              <%}%>
              <p><b><%=hname%></b></p>
              <%if (hdd != hid){%>
              </font></a><font color="#990000"> 
              <%} else {%>
              </font> 
              <%}%>
              <%
} 
Records.Close()
%>
            <li> <a class=globalnav href="message.asp"> 
              <p><b>E-mail</b> 
              </a> 
            <li> <a class=globalnav href="company.asp"> 
              <p><b>Реквизиты</b> 
              </a> 
              <%if (usok) {%>
            <li> 
              <p><b><font face="Arial, Helvetica, sans-serif"><a href="addnewsheading.asp?hid=<%=hid%>"><font color="#006600">Добавить 
                раздел сайта</font></a></font><font face="Arial, Helvetica, sans-serif" size="1"> 
                <%}%>
                </font></b> </p>
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="12">
        <tr> 
          <td></td>
        </tr>
      </table>
      <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr  bgcolor="#333333"> 
          <td width="14">&nbsp;</td>
          <td nowrap valign="middle" align="left"> 
            <p><b> 
              <%
// В переменной bk содержится код блока новостей
var bk=71
// Не забывать его менять!!
Records.Source="Select * from block_news where id="+bk+" and smi_id="+smi_id
Records.Open()
if (!Records.EOF ) {
blokname=TextFormData(Records("SUBJ").Value,"")
}
Records.Close()
%>
              <font color="#CCCCCC"><%=blokname%> </font></b></p>
          </td>
          <td width="14">&nbsp;</td>
        </tr>
      </table>
      <table width="100%" border="1" cellspacing="0" cellpadding="5" class="base_text" bordercolor="#333333">
        <tr> 
          <td bgcolor="#FFFFFF" bordercolor="#FFFFFF" valign="top"> 
            <%
// В переменной bk содержится код блока новостей
var bk=71
// Не забывать его менять!!
var recs=CreateRecordSet()
Records.Source="Select t1.*, t2.posit from publication t1, news_pos t2 where t1.state=1 and t1.id=t2.publication_id and t2.block_news_id="+bk+" order by t2.posit"
Records.Open()
while (!Records.EOF )
{
imgname=""
	pid=String(Records("ID").Value)
	pname=String(Records("NAME").Value)
	url=TextFormData(Records("URL").Value,"newsshow.asp")
	url+="?pid="+pid
	pdat=Records("PUBLIC_DATE").Value
	autor=TextFormData(Records("AUTOR").Value,"")
	digest=TextFormData(Records("DIGEST").Value,"")
	imgname=PubImgPath+pid+".gif"
    if (!fs.FileExists(PubFilePath+pid+".gif")) { imgname="" }
	if (imgname=="") {
		imgname=PubImgPath+pid+".jpg"
		if (!fs.FileExists(PubFilePath+pid+".jpg")) { imgname="" }
	}
	path=""
	//hid=String(Records("HEADING_ID").Value)
	//hdd=hid
	hdd=String(Records("HEADING_ID").Value)
	while (hdd>0) {
	recs.Source="Select * from heading where id="+hdd
	recs.Open()
	nm=String(recs("NAME").Value)
	hadr=TextFormData(recs("URL").Value,"pubheading.asp")
	path="<a href=\""+hadr+"?hid="+hdd+"\">"+nm+"</a> &gt; "+path
	hdd=recs("HI_ID").Value
	recs.Close()
var news=""
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
}

%>
            <li> 
              <p> &nbsp;<a href="newshow.asp?pid=<%=pid%>"><%=pname%></a></p>
              <%
	Records.MoveNext()
} 
Records.Close()
delete recs
%>
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="12">
        <tr> 
          <td></td>
        </tr>
      </table>
    </td>
    <td valign="top" align="left" width="12">&nbsp;</td>
    <td valign="top" align="left" bgcolor="#F2EEE1"> 
      <table border="0" cellspacing="0" cellpadding="0" width="220">
        <tr  bgcolor="#333333"> 
          <td width="14">&nbsp;</td>
          <td nowrap valign="middle"  bgcolor="#333333"> 
            <p><font color="#CCCCCC"><b><%=hiname%></b></font></p>
          </td>
          <td width="14">&nbsp;</td>
        </tr>
      </table>
      <table width="95%" border="1" cellspacing="0" cellpadding="5" class="base_text" bordercolor="#333333" height="300">
        <tr> 
          <td valign="top" bgcolor="#FFFFFF" bordercolor="#FFFFFF"> 
            <%if (tpm<7) {%>
            <font face="Arial, Helvetica, sans-serif" size="1"> | <a href="ednewsheading.asp?hid=<%=hid%>"><b><font color="#006600"> 
            Изменить название раздел</font></b><font color="#006600">а</font></a> 
            </font><font size="1"> |<b> </b><a href="delpubheading.asp?hid=<%=hid%>"><font face="Arial, Helvetica, sans-serif" color="#006600"><b>Удалить 
            раздел</b></font></a></font> <font face="Arial, Helvetica, sans-serif" size="1"><b>|</b></font> 
            <font size="1" face="Arial, Helvetica, sans-serif"><a href="addnewsheading.asp?hid=<%=hid%>"><font color="#006600">Создать 
            подраздел</font></a></font><font face="Arial, Helvetica, sans-serif"><font size="1"> 
            | <a href="addpub.asp?hid=<%=hid%>"> <font color="#006600">Добавить 
            публикацию</font></a></font></font> 
            <%}%>
            <%
var recs=CreateRecordSet()
Records.Source="Select * from heading where hi_id="+hid+" and smi_id="+smi_id+" order by name"
Records.Open()
while (!Records.EOF)
{
	hdd=String(Records("ID").Value)
	hname=String(Records("NAME").Value)
	per=Records("PERIOD").Value
	url=TextFormData(Records("URL").Value,"pubheading.asp")
	url+="?hid="+hdd
	if (isnews==1) {
	recs.Source="Select * from PUBLICATION where state=1 and heading_id="+hid+" and public_date>='TODAY'-"+per+" and public_date<='TODAY' order by public_date desc, id desc"
	} else {
	recs.Source="Select * from PUBLICATION where state=1 and heading_id="+hid+" and public_date<='TODAY' order by public_date desc, id desc"
	}
	recs.Open()
	if (!recs.EOF) {
		nid=String(recs("ID").Value)
		name=String(recs("NAME").Value)
		nadr=TextFormData(recs("URL").Value,"newshow.asp")
		nadr+="?pid="+nid
		ndat=recs("PUBLIC_DATE").Value
	} else {
		nid=0
		name=""
		nadr=""
		ndat=""
	}
	recs.Close()
	kvopub=0
	if (name!="") {
		recs.Source="Select count_pub  from get_count_pub_show("+hdd+")"
		recs.Open()
		kvopub=recs("COUNT_PUB").Value
		recs.Close()
	}
	Records.MoveNext()
%>
            <p><b><a  href="<%=url%>"><%=hname%></a></b></p>
            <%} 
Records.Close()
delete recs
%>
            <%
if (isnews==1){
Records.Source="Select * from publication where heading_id="+hid+"and state=1 and public_date<'TODAY'-"+period+" order by public_date desc, id desc"
} else {
Records.Source="Select * from publication where heading_id="+hid+"and state=1 and public_date<='TODAY' order by public_date desc, id desc"
}
Records.Open()
while (!Records.EOF && pos<=lpag*(1+pg))
{
	imgname=""
	pid=String(Records("ID").Value)
	pname=String(Records("NAME").Value)
	url=TextFormData(Records("URL").Value,"newshow.asp")
	url+="?pid="+pid
	pdat=Records("PUBLIC_DATE").Value
	autor=TextFormData(Records("AUTOR").Value,"")
	digest=TextFormData(Records("DIGEST").Value,"")
	if  (pos>=pp) {
		imgname=PubImgPath+pid+".gif"
    	if (!fs.FileExists(PubFilePath+pid+".gif")) { imgname="" }
		if (imgname=="") {
			imgname=PubImgPath+pid+".jpg"
			if (!fs.FileExists(PubFilePath+pid+".jpg")) { imgname="" }
		}
%>
            <table width="100%" border="0" bordercolor="#FFFFFF" align="center" cellspacing="0" class="base_text">
              <tr valign="top" bordercolor="#FFFFFF"> 
                <td colspan="2">&nbsp; </td>
              </tr>
              <tr valign="top" bordercolor="#FFFFFF"> 
                <td width="150"> 
                  <%if (imgname != "") {%>
                  <img src="<%=imgname%>" > 
                  <%}else{%>
                  &nbsp; 
                  <%}%>
                </td>
                <td bordercolor="#FFFFFF"> 
                  <p><b><a href="<%=url%>"><%=pname%></a></b> <%=digest%> [<a href="<%=url%>">далее</a>] 
                    <%if (usok) {%>
                    <br>
                    <a href="pubresume.asp?pid=<%=pid%>&st=0">Остановить публикацию</a> 
                    | <a href="delpub.asp?pid=<%=pid%>">Удалить публикацию</a>|<br>
                    <a href="bloknews.asp?pid=<%=pid%>">Разместить в блок</a> 
                    | <a href="edpub.asp?pid=<%=pid%>">Редактировать</a> 
                    <%}%>
                  </p>
                </td>
              </tr>
            </table>
            <div align="center"> 
              <%
	}
	Records.MoveNext()
	pos+=1
} 
Records.Close()
%>
              <hr NOSHADE width="300" size="1">
              <p>&nbsp;</p>
            </div>
            <table width="100%" border="0" cellspacing="0"  align="center">
              <tr> 
                <td> 
                  <p align="CENTER"><font face="Arial, Helvetica, sans-serif" size="2"><b> 
                    <%if (pg>0) {%>
                    <a href="archive.asp?hid=<%=hid%>&pg=<%=pg-1%>">Предыдущая 
                    страница раздела</a> 
                    <%
  } 
  if (pos>lpag*(1+pg)) {
  %>
                    <a href="archive.asp?hid=<%=hid%>&pg=<%=pg+1%>">Следующая 
                    страница раздела</a> </b><b> 
                    <%}%>
                    </b></font></p>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="12">
        <tr> 
          <td></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="151" height="1" bgcolor="#000000"></td>
    <td height="1" width="1" bgcolor="#000000"></td>
    <td height="1" bgcolor="#000000"></td>
  <tr bgcolor="#DACFA9"> 
    <td colspan="3"> 
      <div align="center"> 
        <p>&nbsp;</p>
      </div>
    </td>
  </tr>
  <tr> 
    <td width="151" height="1" bgcolor="#000000"></td>
    <td height="1" width="1" bgcolor="#000000"></td>
    <td height="1" bgcolor="#000000"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr bgcolor="#000000"> 
    <td width="300"> 
      <p>&nbsp;</p>
    </td>
    <td align="RIGHT">&nbsp;
    </td>
  </tr>
</table>
<p align="CENTER">| <a href="index.asp"><font face="Arial, Helvetica, sans-serif" size="1"> 
  <b>На главную</b></font></a><font face="Arial, Helvetica, sans-serif" size="1"><b> 
  | 
  <%
// маркек признака новостей
isnews=1
// если необходимо вывести рубрики не новостей то установить в ноль

var recs=CreateRecordSet()
Records.Source="Select * from heading where hi_id=0 and smi_id="+smi_id+" and isnews="+isnews+" order by name"
Records.Open()
while (!Records.EOF)
{
	hid=String(Records("ID").Value)
	hname=String(Records("NAME").Value)
	per=Records("PERIOD").Value
	url=TextFormData(Records("URL").Value,"")
	if (url=="") {url="pubheading.asp"}
	url+="?hid="+hid
	if (isnews==1) {
	recs.Source="Select * from PUBLICATION where state=1 and heading_id="+hid+" and public_date>='TODAY'-"+per+" and public_date<='TODAY' order by public_date desc, id desc"
	} else {
	recs.Source="Select * from PUBLICATION where state=1 and heading_id="+hid+" and public_date<='TODAY' order by public_date desc, id desc"
	}
	recs.Open()
	if (!recs.EOF) {
		nid=String(recs("ID").Value)
		name=String(recs("NAME").Value)
		nadr=TextFormData(recs("URL").Value,"newshow.asp")
		nadr+="?pid="+nid
		ndat=recs("PUBLIC_DATE").Value
	} else {
		nid=0
		name=""
		nadr=""
		ndat=""
	}
	recs.Close()
	Records.MoveNext()
%>
  <a href="<%=url%>"><%=hname%></a> | 
  <%
} Records.Close()
delete recs
%>
  <%
// маркек признака новостей
isnews=0
// если необходимо вывести рубрики не новостей то установить в ноль
var recs=CreateRecordSet()
Records.Source="Select * from heading where hi_id=0 and smi_id="+smi_id+" and isnews="+isnews+" order by name"
Records.Open()
while (!Records.EOF)
{
	hid=String(Records("ID").Value)
	hname=String(Records("NAME").Value)
	per=Records("PERIOD").Value
	url=TextFormData(Records("URL").Value,"")
	if (url=="") {url="pubheading.asp"}
	url+="?hid="+hid
	if (isnews==1) {
	recs.Source="Select * from PUBLICATION where state=1 and heading_id="+hid+" and public_date>='TODAY'-"+per+" and public_date<='TODAY' order by public_date desc, id desc"
	} else {
	recs.Source="Select * from PUBLICATION where state=1 and heading_id="+hid+" and public_date<='TODAY' order by public_date desc, id desc"
	}
	recs.Open()
	if (!recs.EOF) {
		nid=String(recs("ID").Value)
		name=String(recs("NAME").Value)
		nadr=TextFormData(recs("URL").Value,"newshow.asp")
		nadr+="?pid="+nid
		ndat=recs("PUBLIC_DATE").Value
	} else {
		nid=0
		name=""
		nadr=""
		ndat=""
}
	recs.Close()
	
	Records.MoveNext()
%>
  <a href="<%=url%>"><%=hname%></a> | 
  <%
} Records.Close()
delete recs
%>
  </b> </font></p>
<p align="CENTER"><font size="1"><b> | <a href="area.asp">Администратор</a> | 
  <a href="message.asp">Обратная связь</a> | <a href="company.asp">Реквизиты компании</a> 
  |</b></font></p>
<p align="center"><font size="1">&copy; 2002-2005 &quot;<%=sminame%>&quot; программирование 
  <a href="http://www.rusintel.ru">Русинтел</a></font></p>
<hr size="1" noshade align="center" width="468">

</body>
</html>
