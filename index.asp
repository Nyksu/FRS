<%@LANGUAGE="JScript"%>
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\getform.inc" -->
<!-- #include file="inc\err.inc" -->
<!-- #include file="inc\Creaters.inc" -->
<!-- #include file="inc\path.inc" -->

<%
// тут запишем код СМИ... Не забыть изменить его в других сайтах!!
var smi_id=33
// +++  smi_id - код СМИ в таблице SMI !!

var hid=0
var hname=""
var url=""
var nid=0
var name=""
var ndat=""
var nadr=""
var per=0
var kvopub=0
var pname=""
var pdat=""
var autor=""
var digest=""
var imgLname=""
var imgname=""
var path=""
var hdd=0
var hadr=""
var nm=""
var filnam=""
var fs= new ActiveXObject("Scripting.FileSystemObject")
var ts=""
var isnews=1
var ishtml=0
var blokname=""
var tpm=1000
var usok=false
var sminame=""

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

%>
<html>
<head>
<title><%=sminame%></title>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
<style type="text/css">
<!--
p {  font-family: Verdana, Arial, Helvetica, sans-serif; color: #405E82; font-size: 12px}
h1 { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 16px; margin-left: 8px; text-transform: uppercase; margin-top: 3px; margin-bottom: 3px}
.sub { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px ; color: #7293BA}
h2 { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 18px; margin-left: 8px; color: #336699}
.menu {  text-transform: uppercase; color: #FFFFFF; font-size: 10px}
.menutop { text-transform: uppercase; color: #405E82; font-size: 13px; font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: bold}
h3 { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px; margin-left: 8px; color: #336699 }
.red { text-transform: uppercase; color: #CC3333; font-size: 13px; font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: bold }
-->
</style>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0" background="images/top_bg.jpg" height="269">
  <tr> 
    <td width="300" align="center"><img src="images/flag_top.jpg" width="207" height="269" alt="<%=sminame%>"></td>
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="269">
        <tr> 
          <td height="63">&nbsp;</td>
        </tr>
        <tr> 
          <td height="98"> 
            <h1><font face="Verdana, Arial, Helvetica, sans-serif"><b><font size="4" color="#FFFFFF">Управление <br>
              Федеральной регистрационной службы</font></b></font></h1>
          </td>
        </tr>
        <tr> 
          <td valign="top"> 
            <h2>по Тюменской области, Ханты-Мансийскому и Ямало-Ненецкому автономным округам</h2>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="sub"><img src="images/blue_dot.jpg" width="15" height="15" align="absmiddle"> 
                  FRS.72RUS.RU</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
    <td width="123"><img src="images/herb.jpg" width="123" height="269"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="4" cellpadding="0" height="300">
  <tr> 
    <td width="314" align="right" valign="top"> 
      <div align="center"><img src="III.gif" width="168" height="168">
      </div>
      <table width="314" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30" align="right"> 
            <ul>
              <li class="red"><a href="/" class="red">Главная</a>
              </li>
            </ul>
          </td>
        </tr>
        <tr> 
          <td><img src="images/dot_hor.jpg" width="314" height="5"></td>
        </tr>
      </table>
	  <%
var recs=CreateRecordSet()
Records.Source="Select * from heading where hi_id="+hid+" and smi_id="+smi_id+" and isnews="+isnews+" order by name"
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
      <table width="314" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30" align="right"> 
            <ul>
              <li  class="menutop"><a  class="menutop" href="<%=url%>"><%=hname%></a></li>
            </ul>
          </td>
        </tr>
        <tr> 
          <td><img src="images/dot_hor.jpg" width="314" height="5"></td>
        </tr>
      </table>
<%
} 
Records.Close()
delete recs
%>
<%
isnews=0
var recs=CreateRecordSet()
Records.Source="Select * from heading where hi_id="+hid+" and smi_id="+smi_id+" and isnews="+isnews+" order by name"
Records.Open()
while (!Records.EOF)
{
	hdd=String(Records("ID").Value)
	hname=String(Records("NAME").Value)
	per=Records("PERIOD").Value
	url=TextFormData(Records("URL").Value,"pubheading.asp")
	url+="?hid="+hdd
	if (isnews==0) {
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
      <table width="314" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30" align="right">
            <ul>
              <li  class="menutop"><a  class="menutop"  href="<%=url%>"><%=hname%></a></li>
            </ul>
          </td>
        </tr>
        <tr> 
          <td><img src="images/dot_hor.jpg" width="314" height="5"></td>
        </tr>
      </table>
 <%
} 
Records.Close()
delete recs
%>
<table width="314" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30" align="right">
            <ul>
              <li  class="menutop"><a  class="menutop"  href="message.asp">Обратная 
                связь</a> </li>
            </ul>
          </td>
        </tr>
        <tr> 
          <td><img src="images/dot_hor.jpg" width="314" height="5"></td>
        </tr>
      </table>
      <table width="314" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30" align="right"> 
            <ul>
              <li  class="menutop"><a  class="menutop"  href="company.asp">Реквизиты</a> 
              </li>
            </ul>
          </td>
        </tr>
        <tr> 
          <td><img src="images/dot_hor.jpg" width="314" height="5"></td>
        </tr>
      </table>
      <p><a href="http://www.kadastr.ru/" target="_blank"><img src="rossnedvijimost.jpg" alt="Управление Роснедвижимости" width="130" height="130" border="0"></a> </p>
      <p>
        <%if (usok) {%>
          <a href="addnewsheading.asp?hid=<%=hid%>" class="sub">+ Добавить раздел сайта</a><br>
        <%}%>
        <br>
        <!--begin of Top100-->
        <a href="http://top100.rambler.ru/top100/"><img src="http://counter.rambler.ru/top100.cnt?1046923" alt="Rambler's Top100" width=1 height=1 border=0></a>
        <!--end of Top100 code-->
        <!--begin of Top100 logo-->
        <a href="http://top100.rambler.ru/top100/"><img src="http://top100-images.rambler.ru/top100/banner-88x31-rambler-blue.gif" alt="Rambler's Top100" width=88 height=31 border=0></a>
        <!--end of Top100 logo -->
    </p></td>
    <td width="8" valign="top" background="images/vert_separat.jpg"><img src="images/vert_separat.jpg" width="8" height="6"></td>
    <td valign="top">&nbsp;</td>
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td bgcolor="#5A80AE"> 
<%
// В переменной bk содержится код блока новостей
var bk=160
// Не забывать его менять!!
Records.Source="Select * from block_news where id="+bk+" and smi_id="+smi_id
Records.Open()
if (!Records.EOF ) {
blokname=TextFormData(Records("SUBJ").Value,"")
}
Records.Close()
%>
<h1><font color="#FFFFFF"><i><%=blokname%></i></font></h1>
          </td>
          <td width="105" background="images/titl_bg.jpg"><img src="images/titl_bg.jpg" width="105" height="26"></td>
          <td valign="bottom"><a href="/"><img src="images/home.jpg" width="31" height="28" border="0" alt="На главную страницу"></a><a href="message.asp"><img src="images/mail.jpg" width="38" height="28" border="0" alt="Обратная связь"></a><a href="search.asp"><img src="images/search.jpg" width="31" height="28" alt="Поиск" border="0"></a></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="3"></td>
          <td width="200"></td>
        </tr>
        <tr> 
          <td bgcolor="#5A80AE" height="2"><img src="images/line_start.jpg" width="100%" height="2"></td>
          <td width="200"><img src="images/line_end.jpg" width="150" height="2"></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="30">
        <tr> 
          <td></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="90%"> <%
// В переменной bk содержится код блока новостей
var bk=160
// Не забывать его менять!!
var recs=CreateRecordSet()
Records.Source="Select t1.*, t2.posit from publication t1, news_pos t2 where t1.state=1 and t1.id=t2.publication_id and t2.block_news_id="+bk+" order by t2.posit"
Records.Open()
while (!Records.EOF )
{
imgLname=""
	pid=String(Records("ID").Value)
	pname=String(Records("NAME").Value)
	url=TextFormData(Records("URL").Value,"newsshow.asp")
	url+="?pid="+pid
	pdat=Records("PUBLIC_DATE").Value
	autor=TextFormData(Records("AUTOR").Value,"")
	digest=TextFormData(Records("DIGEST").Value,"")
	imgLname=PubImgPath+"l"+pid+".gif"
    if (!fs.FileExists(PubFilePath+"l"+pid+".gif")) { imgLname="" }
	if (imgLname=="") {
		imgLname=PubImgPath+"l"+pid+".jpg"
		if (!fs.FileExists(PubFilePath+"l"+pid+".jpg")) { imgLname="" }
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
		    <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><%if (imgLname != "") {%>
            <table border="0" cellspacing="8" cellpadding="0" align="left">
              <tr> 
                <td><img src="<%=imgLname%>" alt="<%=pname%>"></td>
              </tr>
            </table>
			<%}else{%>
            <%}%>
            <h3><b><a href="newshow.asp?pid=<%=pid%>"><%=pname%></a></b></h3>
            <p><%=digest%></p></td>
              </tr>
            </table>
		    
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="8">
<tr> 
<td height="8" background="images/text_separat.jpg"><img src="images/text_separat.jpg" width="6" height="8"></td>
</tr>
</table>			
            <%
Records.MoveNext()
} 
Records.Close()
delete recs
%>
            <%
// В переменной bk содержится код блока новостей
var bk=161
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
            <h3><b><a href="newshow.asp?pid=<%=pid%>"><%=pname%></a></b></h3>
             <p> [<%=pdat%>] <%=digest%>. [<a href="newshow.asp?pid=<%=pid%>">далее</a>]</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="8">
<tr> 
<td height="8" background="images/text_separat.jpg"><img src="images/text_separat.jpg" width="6" height="8"></td>
</tr>
</table>
<%
	Records.MoveNext()
} 
Records.Close()
delete recs
%>          </td>
          <td>&nbsp;</td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="60">
        <tr> 
          <td></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="4" cellpadding="0">
  <tr> 
    <td width="314" align="right" valign="top">&nbsp;</td>
    <td width="8" valign="top" background="images/vert_separat.jpg">&nbsp;</td>
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td align="center" width="25%"> 
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr> 
                <td width="5">&nbsp;</td>
                <td bgcolor="#D13328" align="center"> 
                  <p><a href="/" class="menu"><b>В начало</b></a></p>
                </td>
                <td background="images/red_end.jpg" width="18"><img src="images/red_end.jpg" width="18" height="18"></td>
              </tr>
            </table>
          </td>
          <td width="25%"> 
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr> 
                <td width="5">&nbsp;</td>
                <td bgcolor="#5A80AE" align="center"> 
                  <p><a href="message.asp" class="menu"><b>E-mail</b></a></p>
                </td>
                <td background="images/blue_end.jpg" width="18"><img src="images/blue_end.jpg" width="18" height="18"></td>
              </tr>
            </table>
          </td>
          <td width="25%"> 
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr> 
                <td width="5">&nbsp;</td>
                <td bgcolor="#5A80AE" align="center"> 
                  <p><a href="search.asp" class="menu"><b>Поиск</b></a></p>
                </td>
                <td background="images/blue_end.jpg" width="18"><img src="images/blue_end.jpg" width="18" height="18"></td>
              </tr>
            </table>
          </td>
          <td width="25%"> 
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr> 
                <td width="5">&nbsp;</td>
                <td bgcolor="#5A80AE" align="center"> 
                  <p><a href="company.asp" class="menu"><b>Реквизиты</b></a></p>
                </td>
                <td background="images/blue_end.jpg" width="18"><img src="images/blue_end.jpg" width="18" height="18"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="4" cellpadding="0">
  <tr> 
    <td width="314" align="right" valign="top">&nbsp;</td>
    <td width="8" valign="top" background="images/vert_separat.jpg">&nbsp;</td>
    <td width="120"><a href="/"><img src="images/home.jpg" width="31" height="28" border="0" alt="На главную страницу"></a><a href="message.asp"><img src="images/mail.jpg" width="38" height="28" border="0" alt="Обратная связь"></a><a href="search.asp"><img src="images/search.jpg" width="31" height="28" alt="Поиск" border="0"></a></td>
    <td> 
      <p class="sub">&copy; 2006 <a href="/" class="sub">Управление Федеральной 
        регистрационной службы</a></p>
    </td>
    <td valign="top" align="right" width="73"><a href="area.asp"><img src="images/flag_small.jpg" width="73" height="92" border="0"></a></td>
  </tr>
</table>
</body>
</html>
