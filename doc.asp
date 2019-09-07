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
var docname=""

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
		isnews=Records("ISNEWS").Value
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
<style type="text/css">
<!--
p {  font-family: Verdana, Arial, Helvetica, sans-serif; color: #405E82; font-size: 12px}
h1 { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 16px; margin-left: 8px; text-transform: uppercase; margin-top: 3px; margin-bottom: 3px}
.sub { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px ; color: #7293BA}
h2 { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 18px; margin-left: 8px; color: #336699}
.menu {  text-transform: uppercase; color: #FFFFFF; font-size: 10px}
.menutop { text-transform: uppercase; color: #405E82; font-size: 13px; font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: bold}
h3 { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px; margin-left: 8px; color: #336699 }
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
            <h1><font face="Verdana, Arial, Helvetica, sans-serif"><b><font size="4" color="#FFFFFF">Управление 
              <br>
              Федеральной регистрационной службы</font></b></font></h1>
          </td>
        </tr>
        <tr> 
          <td valign="top"> 
            <h2>по Тюменской области, Ханты-Мансийскому и Ямало-Ненецкому автономным округам</h2>
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
      <table width="314" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30" align="right"> 
            <p><a href="/" class="menutop">Главная</a> <img src="images/blue_dot.jpg" width="15" height="15" align="absmiddle"></p>
          </td>
        </tr>
        <tr> 
          <td><img src="images/dot_hor.jpg" width="314" height="5"></td>
        </tr>
      </table><%
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
<%if (hdd != hid){%>
      <table width="314" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30" align="right"> 
            <p><a href="<%=url%>"  class="menutop"><%=hname%></a> <img src="images/blue_dot.jpg" width="15" height="15" align="absmiddle"></p>
          </td>
        </tr>
        <tr> 
          <td><img src="images/dot_hor.jpg" width="314" height="5"></td>
        </tr>
      </table>
<%}else{%>
      <table width="314" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30" align="right"> 
            <p><a href="<%=url%>" class="menutop"><font color="#CC0000"><%=hname%></font></a> <img src="images/red_dot.jpg" width="15" height="15" align="absmiddle"></p>
          </td>
        </tr>
        <tr> 
          <td><img src="images/dot_hor.jpg" width="314" height="5"></td>
        </tr>
      </table>
<%
}
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
<%if (hdd != hid){%>
      <table width="314" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30" align="right"> 
            <p><a href="<%=url%>"  class="menutop"><%=hname%></a> <img src="images/blue_dot.jpg" width="15" height="15" align="absmiddle"></p>
          </td>
        </tr>
        <tr> 
          <td><img src="images/dot_hor.jpg" width="314" height="5"></td>
        </tr>
      </table>
<%}else{%>
      <table width="314" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30" align="right"> 
            <p><a href="<%=url%>" class="menutop"><font color="#CC0000"><%=hname%></font></a> <img src="images/red_dot.jpg" width="15" height="15" align="absmiddle"></p>
          </td>
        </tr>
        <tr> 
          <td><img src="images/dot_hor.jpg" width="314" height="5"></td>
        </tr>
      </table>
      <%
	  }
} 
Records.Close()
%>
%>
<table width="314" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30" align="right"><p><a  class="menutop"  href="message.asp">Обратная связь</a> <img src="images/blue_dot.jpg" width="15" height="15" align="absmiddle"></p></td>
        </tr>
        <tr> 
          <td><img src="images/dot_hor.jpg" width="314" height="5"></td>
        </tr>
      </table>
      <table width="314" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30" align="right">
            <p><a  class="menutop"  href="company.asp">Реквизиты</a> <img src="images/blue_dot.jpg" width="15" height="15" align="absmiddle"></p>
          </td>
        </tr>
        <tr> 
          <td><img src="images/dot_hor.jpg" width="314" height="5"></td>
        </tr>
      </table>
 <%if (usok) {%><a href="addnewsheading.asp?hid=0" class="sub">+ Добавить раздел сайта</a><br><%}%>
 <!--begin of Top100-->
<a href="http://top100.rambler.ru/top100/"><img src="http://counter.rambler.ru/top100.cnt?1046923" alt="Rambler's Top100" width=1 height=1 border=0></a>
<!--end of Top100 code-->
<!--begin of Top100 logo-->
<a href="http://top100.rambler.ru/top100/"><img src="http://top100-images.rambler.ru/top100/banner-88x31-rambler-blue.gif" alt="Rambler's Top100" width=88 height=31 border=0></a>
<!--end of Top100 logo -->
    </td>
    <td width="8" valign="top" background="images/vert_separat.jpg"><img src="images/vert_separat.jpg" width="8" height="6"></td>
    <td valign="top">&nbsp;</td>
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td bgcolor="#5A80AE"> 
            <h1><font color="#FFFFFF"><i><%=hiname%></i></font></h1>
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
          <td valign="middle"> 
            <%if (tpm<7) {%>
            <p><a href="ednewsheading.asp?hid=<%=hid%>" class="sub">Настройки 
              раздела</a> | <a href="delpubheading.asp?hid=<%=hid%>" class="sub">Удалить 
              раздел</a> | <a href="addnewsheading.asp?hid=<%=hid%>" class="sub">Создать 
              подраздел</a> | <a href="addpub.asp?hid=<%=hid%>" class="sub">+ Добавить 
              новую запись</a></p>
            <%}%>
</td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="90%" valign="top"> 
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
            <p><a  href="<%=url%>"  class="menutop"><%=hname%></a></p> 
<%} 
Records.Close()
delete recs
%>
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
Records.Source="Select * from publication where heading_id="+hid+"and state=1 and public_date<='TODAY' order by public_date desc, id desc"
Records.Open()
while (!Records.EOF && pos<=lpag*(1+pg))
{
	docname=""
	pid=String(Records("ID").Value)
	pname=String(Records("NAME").Value)
	url=""
	pdat=Records("PUBLIC_DATE").Value
	autor=TextFormData(Records("AUTOR").Value,"")
	digest=TextFormData(Records("DIGEST").Value,"")
	if  (pos>=pp) {
		docname=PubImgPath+pid+".rtf"
    	if (!fs.FileExists(PubFilePath+pid+".rtf")) { docname="" }
		if (docname!="") {url="/"+docname}
%>
                              
            <table width="99%" border="0" bordercolor="#FFFFFF" align="center" class="base_text" cellspacing="0">
              <tr valign="top" bordercolor="#FFFFFF"> 
                <td colspan="2" height="15"></td>
              </tr>
                                <tr valign="top" bordercolor="#FFFFFF"> 
                                  <td align="center"><a href="<%=(url=="")?"pubdheading.asp?hid="+hid:url%>" target="_blank"><img src="images/msword.gif" border="0" alt="<%=pname%> - Файл в формате .RTF" width="40" height="33"></a> 
                                  </td>
                <td bordercolor="#FFFFFF"> 
                  <p> [<%=pdat%>] 
                    <b><a href="<%=(url=="")?"pubdheading.asp?hid="+hid:url%>" target="_blank"><%=pname%></a></b></p>
                  <p><%=digest%>
                    <%if (usok) {%>
                    <br>
                    <a href="addpubdoc.asp?hd=<%=hid%>&pid=<%=pid%>" class="sub">Загрузить файл (RTF)</a>
					| <a href="delpub.asp?pid=<%=pid%>" class="sub">Удалить запись</a>
					| <a href="edpub.asp?pid=<%=pid%>" class="sub">Редактировать</a> 
                    <%}%>
                  </p>
                </td>
              </tr>
            </table>
                              
            <%
	}
	Records.MoveNext()
	pos+=1
} 
Records.Close()
%>
            <hr NOSHADE width="25" size="1">
            <table width="100%" border="0" cellspacing="0"  align="center">
              <tr> 
                <td> 
<p align="CENTER"> 
<%if (pg>0) {%>
<a href="pubheading.asp?hid=<%=hid%>&pg=<%=pg-1%>">Предыдущая  страница</a> 
<%
  } 
  if (pos>lpag*(1+pg)) {
%>
<a href="pubheading.asp?hid=<%=hid%>&pg=<%=pg+1%>">Следующая страница</a> 
<%}%>
                   </p>
                </td>
              </tr>
            </table>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" height="8">
              <tr> 
                <td height="8" background="images/text_separat.jpg"><img src="images/text_separat.jpg" width="6" height="8"></td>
              </tr>
            </table>
          </td>
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
