<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\getform.inc" -->
<!-- #include file="inc\creaters.inc" -->
<!-- #include file="inc\err.inc" -->
<!-- #include file="inc\path.inc" -->
<!-- #include file="inc\url.inc" -->



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
var blokname=""
var tpm=1000
var usok=false
var ishtml=0
var urlname=""
var urlid=0
var urlabout=""
var daterenew=""
var urladr=""
var urlcount=0
var msgcount=0
var sminame=""
var pid=0
var news=""


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

var tps=parseInt(Request("tps"))
var sens=parseInt(Request("sensation"))
if (isNaN(sens)) {sens=0}
var sch=TextFormData(Request("sch"),"")
if (isNaN(tps)) {tps=1}
var wrds=parseInt(Request("wrds"))
if (isNaN(wrds)) {wrds=0}
var pg=parseInt(Request("pg"))
if (isNaN(pg)) {pg=0}
var lp=15 // Длина страницы
var sstr=""
var ssql=""
var qsql=""
var ii=0
var name=""
var id=0
var coment=""
var kvo=0
var tkvo=0
var dat=""
var url=""
var ll=0

if (sch!="") {
	// Какой-то запрос
	sstr=sch
	while (sch.indexOf(".")>=0) {sch=sch.replace(".","")}
	while (sch.indexOf(",")>=0) {sch=sch.replace(","," ")}
	while (sch.indexOf(" - ")>=0) {sch=sch.replace(" - "," ")}
	while (sch.indexOf(" -")>=0) {sch=sch.replace(" -"," ")}
	while (sch.indexOf("- ")>=0) {sch=sch.replace("- "," ")}
	while (sch.indexOf(";")>=0) {sch=sch.replace(";"," ")}
	while (sch.indexOf(":")>=0) {sch=sch.replace(":"," ")}
	while (sch.indexOf("\"")>=0) {sch=sch.replace("\"","")}
	while (sch.indexOf("'")>=0) {sch=sch.replace("'","")}
	while (sch.indexOf("(")>=0) {sch=sch.replace("(","")}
	while (sch.indexOf(")")>=0) {sch=sch.replace(")","")}
	while (sch.indexOf("<")>=0) {sch=sch.replace("<"," ")}
	while (sch.indexOf(">")>=0) {sch=sch.replace(">"," ")}
	while (sch.indexOf("?")>=0) {sch=sch.replace("?"," ")}
	while (sch.indexOf("=")>=0) {sch=sch.replace("="," ")}
	while (sch.indexOf(" % ")>=0) {sch=sch.replace(" % "," ")}
	while (sch.indexOf(" _ ")>=0) {sch=sch.replace(" _ "," ")}
	while (sch.indexOf("+")>=0) {sch=sch.replace("+"," ")}
	while (sch.indexOf("  ")>=0) {sch=sch.replace("  "," ")}
	ll=sch.length
	if (ll<3) {sch=""}
	if (sch.indexOf(" ")==0) {sch=sch.substring(1,ll)}
	ll=sch.length
	if (ll<3) {sch=""}
	if (sch.indexOf(" ")==ll-1) {sch=sch.substring(0,ll-1)}
	if (wrds==0) {sch=""}
	//
	//
	//
	if (sch!="") {
		ssql=sch
		while (ssql.indexOf(" ")>=0) {ssql=ssql.replace(" ","+")}
		if (sens==1) {
			if (wrds==1) { // С учетом регистра букв ВСЕ слова
				while (ssql.indexOf("+")>=0) {ssql=ssql.replace("+","%' and t1.name like  '%")}
				ssql="Select t1.* from publication t1, heading t2 where t1.heading_id=t2.id and t2.smi_id="+smi_id+" and t1.state=1 and t1.name like '%"+ssql+"%' "
				qsql=sch
				while (qsql.indexOf(" ")>=0) {qsql=qsql.replace(" ","+")}
				while (qsql.indexOf("+")>=0) {qsql=qsql.replace("+","%' and t1.digest like  '%")}
				qsql="Select t1.* from publication t1, heading t2 where t1.heading_id=t2.id and t2.smi_id="+smi_id+" and t1.state=1 and t1.digest like '%"+qsql+"%'"
			}
			if (wrds==2) { // С учетом регистра букв Хотябы одно слово
				while (ssql.indexOf("+")>=0) {ssql=ssql.replace("+","%' or t1.name like  '%")}
				ssql="Select t1.* from publication t1, heading t2 where t1.heading_id=t2.id and t2.smi_id="+smi_id+" and t1.state=1 and (t1.name like '%"+ssql+"%') "
				qsql=sch
				while (qsql.indexOf(" ")>=0) {qsql=qsql.replace(" ","+")}
				while (qsql.indexOf("+")>=0) {qsql=qsql.replace("+","%' or t1.digest like  '%")}
				qsql="Select t1.* from publication t1, heading t2 where t1.heading_id=t2.id and t2.smi_id="+smi_id+" and t1.state=1 and (t1.digest like '%"+qsql+"%')"
			}
			if (wrds==3) { // С учетом регистра букв Фраза целиком
				while (ssql.indexOf("+")>=0) {ssql=ssql.replace("+"," ")}
				ssql="Select t1.* from publication t1, heading t2 where t1.heading_id=t2.id and t2.smi_id="+smi_id+" and t1.state=1 and t1.name like '%"+ssql+"%' "
				qsql=sch
				while (qsql.indexOf("+")>=0) {qsql=qsql.replace("+"," ")}
				qsql="Select t1.* from publication t1, heading t2 where t1.heading_id=t2.id and t2.smi_id="+smi_id+" and t1.state=1 and t1.digest like '%"+qsql+"%'"
			}
		} else {
			if (wrds==1) { // Без учета регистра букв ВСЕ слова
				while (ssql.indexOf("+")>=0) {ssql=ssql.replace("+","%') and UpCase(t1.name) like  UpCase('%")}
				ssql="Select t1.* from publication t1, heading t2 where t1.heading_id=t2.id and t2.smi_id="+smi_id+" and t1.state=1 and UpCase(t1.name) like UpCase('%"+ssql+"%') "
				qsql=sch
				while (qsql.indexOf(" ")>=0) {qsql=qsql.replace(" ","+")}
				while (qsql.indexOf("+")>=0) {qsql=qsql.replace("+","%') and UpCase(t1.digest) like  UpCase('%")}
				qsql="Select t1.* from publication t1, heading t2 where t1.heading_id=t2.id and t2.smi_id="+smi_id+" and t1.state=1 and UpCase(t1.digest) like UpCase('%"+qsql+"%')"
			}
			if (wrds==2) { // Без учета регистра букв Хотябы одно слово
				while (ssql.indexOf("+")>=0) {ssql=ssql.replace("+","%') or UpCase(t1.name) like  UpCase('%")}
				ssql="Select t1.* from publication t1, heading t2 where t1.heading_id=t2.id and t2.smi_id="+smi_id+" and t1.state=1 and (UpCase(t1.name) like UpCase('%"+ssql+"%')) "
				qsql=sch
				while (qsql.indexOf(" ")>=0) {qsql=qsql.replace(" ","+")}
				while (qsql.indexOf("+")>=0) {qsql=qsql.replace("+","%') or UpCase(t1.digest) like  UpCase('%")}
				qsql="Select t1.* from publication t1, heading t2 where t1.heading_id=t2.id and t2.smi_id="+smi_id+" and t1.state=1 and (UpCase(t1.digest) like UpCase('%"+qsql+"%'))"
			}
			if (wrds==3) { // Без учета регистра букв Фраза целиком
				while (ssql.indexOf("+")>=0) {ssql=ssql.replace("+"," ")}
				ssql="Select t1.* from publication t1, heading t2 where t1.heading_id=t2.id and t2.smi_id="+smi_id+" and t1.state=1 and UpCase(t1.name) like UpCase('%"+ssql+"%') "
				qsql=sch
				while (qsql.indexOf("+")>=0) {qsql=qsql.replace("+"," ")}
				qsql="Select t1.* from publication t1, heading t2 where t1.heading_id=t2.id and t2.smi_id="+smi_id+" and t1.state=1 and UpCase(t1.digest) like UpCase('%"+qsql+"%')"
			}
		}
		ssql=ssql+" UNION "+qsql+" order by 2"
	}
	
}

%>
<html>
<head>
<title>Поиск на сайте <%=sminame%></title>
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
            <h1><font face="Verdana, Arial, Helvetica, sans-serif"><b><font size="4" color="#FFFFFF">Главное 
              управление <br>
              Федеральной регистрационной службы</font></b></font></h1>
          </td>
        </tr>
        <tr> 
          <td valign="top"> 
            <h2>по Тюменской области, Ханты-Мансийскому и Ямало-Ненецкому автономным округам</h2>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="sub"><img src="images/blue_dot.jpg" width="15" height="15" align="absmiddle"> 
                  <a href="/" class="sub">FRS.72RUS.RU</a> / Поиск на сайте</td>
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
      <table width="314" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30" align="right"> 
            <ul>
              <li class="menutop"><a href="/" class="menutop">Главная</a></li>
            </ul>
          </td>
        </tr>
        <tr> 
          <td><img src="images/dot_hor.jpg" width="314" height="5"></td>
        </tr>
      </table>
      <!-- #include file = "menu.asp" -->
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
<br><!--begin of Top100-->
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
            <h1><font color="#FFFFFF"><i>Поиск на сайте</i></font></h1>
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
          <td width="90%" valign="top"> 
            <form name="form1" method="post" action="search.asp">
              <div style="padding-left: 10px"> 
                <table cellpadding="5" cellspacing="0" border="0" background="">
                  <tr> 
                    <th width="80">
                      <p>ПОИСК</p>
                    </th>
                    <td> 
                      <input type="text" name="sch" size="30" align="right"  value="<%=sch%>">
                      <select name="wrds" style="BACKGROUND-COLOR: #FFFFFF; BORDER-BOTTOM: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-RIGHT: #000000 1px solid; BORDER-TOP: #000000 1px solid; COLOR: #303030; FONT-FAMILY: tahoma; FONT-SIZE: 11px; WIDTH: 100px">
                              <option value="1" <%=wrds==1?"selected":""%>>Все 
                              слова</option>
                              <option value="2" <%=wrds==2?"selected":""%>>Одно 
                              из слов</option>
                              <option value="3" <%=wrds==3?"selected":""%>>Фраза 
                              целиком</option>
                            </select>
                      &nbsp; 
                    <input type="image" name="Findit"  src="images/b_go.gif" width="21" height="27" alt="" border="0" hspace="5" align="absmiddle">
                    </td>
                  </tr>
                </table>
                <p style="font-size: 9px; margin-left: 30px; margin-top: 0px; margin-bottom: 0px; padding-bottom: 0px;">ВВЕДИТЕ 
                  КЛЮЧЕВОЕ СЛОВО <input type="checkbox" name="sensation" value="1" <%=sens==1?"checked":""%>> УЧИТЫВАТЬ РЕГИСТР</p>
              </div>
            </form>
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
          <td><!-- main -->
            <br>
            <table border="0" cellpadding="0" cellspacing="0" align="center" width="100%" height="270">
              <tr valign="top"> 
                <td>&nbsp;</td>
                <td width="100%"> 
                  <p class="sub">ПОИСК: &quot;<%=sch%>&quot;</p>                </td>
                <td background="images/t_fon.gif" align="right">&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="3"> 
                  <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr> 
                      <td bgcolor="#C8C8C8"><img src="images/px1.gif" width="1" height="1" alt="" border="0"></td>
                      <td bgcolor="#C8C8C8"><img src="images/px1.gif" width="1" height="1" alt="" border="0"></td>
                      <td bgcolor="#C8C8C8"><img src="images/px1.gif" width="1" height="1" alt="" border="0"></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#C8C8C8"><img src="images/px1.gif" width="1" height="1" alt="" border="0"></td>
                      <td width="100%" background="images/fon01.jpg" style="background-position: center; background-repeat: repeat-y;"> 
                        <table border="0" cellpadding="10" cellspacing="0" width="100%" background="" height="250">
                          <tr valign="top"> 
                            <td bgcolor="#F4F4F4"><p><%=""%></p>
                  <%
if (ssql!="") {
//Records.CursorType=3
Records.Source=ssql
Records.Open()
if (!Records.EOF) {
kvo=Records.RecordCount
if ((pg+1)*lp > kvo) {tkvo=kvo} else {tkvo=(pg+1)*lp}
%>
                              <p align="left">Найдено публикаций: <%=kvo%></p>
                  <%
	ii=0
	while ((!Records.EOF) && (ii<tkvo)) {
		ii+=1
		id=String(Records("ID").Value)
		name=String(Records("NAME").Value)
		coment=TextFormData(Records("DIGEST").Value,"")
		dat=Records("PUBLIC_DATE").Value
		url=TextFormData(Records("URL").Value,"newshow.asp")
		url+="?pid="+id
		if (ii>=(pg*lp+1)) {
%>
                  <table width="100%" border="0" bordercolor="#FFFFFF" cellspacing="0" cellpadding="0">
                    <tr bgcolor="#EBF3F5"> 
                                  <td width="6%" bgcolor="#EFF1F1" valign="top"> 
                                    <div align="center"> 
                                      <p><%=ii%>.</p>
                        </div>
                      </td>
                                  <td valign="top" bgcolor="#EFF1F1"> 
                                    <div align="left"> 
                                      <p><b><a href="<%=url%>" target="_blank"><%=name%></a></b> 
                                        <font color="#999999">[ <%=dat%> ]</font></p>
                        </div>
                      </td>
                    </tr>
                    <tr bgcolor="#FBFDFD"> 
                      <td colspan="2"> 
                        <p><font size="2"><%=coment%></font></p>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="2" height="6"></td>
                    </tr>
                  </table>
                  <%
		}
		Records.MoveNext()
	}
}
Records.Close()
%>
                  <hr noshade size="1">
                  <p>Страницы: 
                    <%
for ( ii=1; ii<(kvo/lp + 1) ; ii++) {
%>
                    <% if (ii==(pg+1)) { %>
                    <%=ii%> | 
                    <%} else {%>
                    <a href="search.asp?sch=<%=sch%>&wrds=<%=wrds%>&sensation=<%=sens%>&tps=<%=tps%>&pg=<%=ii-1%>"><%=ii%></a> 
                    | 
                    <%}%>
                    <%
}
%>
                  </p>
                  <%
}
%></td>
                          </tr>
                        </table>
                      </td>
                      <td bgcolor="#C8C8C8"><img src="images/px1.gif" width="1" height="1" alt="" border="0"></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#C8C8C8"><img src="images/px1.gif" width="1" height="1" alt="" border="0"></td>
                      <td bgcolor="#C8C8C8"><img src="images/px1.gif" width="1" height="1" alt="" border="0"></td>
                      <td bgcolor="#C8C8C8"><img src="images/px1.gif" width="1" height="1" alt="" border="0"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            <!-- /main -->
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="8">
              <tr> 
                <td height="8" background="images/text_separat.jpg"><img src="images/text_separat.jpg" width="6" height="8"></td>
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
                  <p><a href="search.asp" class="menu"><b>поиск</b></a></p>
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
      <p class="sub">&copy; 2006 <a href="/" class="sub">Главное управление Федеральной 
        регистрационной службы</a></p>
    </td>
    <td valign="top" align="right" width="73"><img src="images/flag_small.jpg" width="73" height="92"></td>
  </tr>
</table>
</body>
</html>
