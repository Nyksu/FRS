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
	path="<a href=\""+hadr+"?hid="+hdd+"\" class=\"sub\">"+nm+"</a> /  "+path
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

path="<a href=\"index.asp\" class=\"sub\">FRS.72RUS.RU</a>  /  "+path
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
<title><%=tit%> > <%=pname%></title>
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
            <h1><font face="Verdana, Arial, Helvetica, sans-serif"><b><font size="4" color="#FFFFFF">У</font><font size="4" color="#FFFFFF">правление 
              <br>
              Федеральной регистрационной службы</font></b></font></h1>
          </td>
        </tr>
        <tr> 
          <td valign="top"> 
            <h2>по Тюменской области, Ханты-Мансийскому и Ямало-Ненецкому автономным округам</h2>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="sub"><img src="images/blue_dot.jpg" width="15" height="15" align="absmiddle"> 
                  <%=path%></td>
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
      <%
isnews=1
Records.Source="Select * from heading where hi_id=0 and smi_id="+smi_id+" and isnews="+isnews+" order by id"
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
      <table width="314" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30" align="right"> 
            <ul>
              <li  class="menutop"><a href="<%=url%>"  class="menutop"><%=hname%></a> 
              </li>
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
%>
      <%
isnews=0
Records.Source="Select * from heading where hi_id=0 and smi_id="+smi_id+" and isnews="+isnews+" order by id"
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
      <table width="314" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30" align="right"> 
            <ul>
              <li class="menutop"><a href="<%=url%>"  class="menutop"><%=hname%></a> 
              </li>
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
      <p><img src="III.gif" width="168" height="168"></p>
      <p><a href="http://www.kadastr.ru/" target="_blank"><img src="rossnedvijimost.jpg" alt="Управление Роснедвижимости" width="130" height="122" border="0"></a> </p>
      <p>
        <%if (usok) {%>
          <a href="addnewsheading.asp?hid=0" class="sub">+ Добавить раздел сайта</a><br>
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
          <td><% if (lgok) {%>
            <a href="addpubimg.asp?pid=<%=pid%>" class="sub">Добавить фото</a> 
            <%}%>
            <%if (usok) {%>
            | <a href="pubresume.asp?pid=<%=pid%>&st=0" class="sub">Остановить</a> 
            | <a href="delpub.asp?pid=<%=pid%>" class="sub">Удалить</a> 
            | <a href="bloknews.asp?pid=<%=pid%>" class="sub">Разместить в блок</a>
			| <a href="edpub.asp?pid=<%=pid%>" class="sub">Редактировать</a> 
            <%}%></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="90%"> 
		  <h3><b><%=pname%></b></h3>
		  <%if (imgLname != "") {%>
            <table border="0" cellspacing="8" cellpadding="0" align="left">
              <tr> 
                <td><img src="<%=imgLname%>" alt="<%=pname%>"></td>
              </tr>
            </table>
			<%}else{%><%}%>
            <p><%=news%></p>
			<p class="sub"><%=pdat%>&nbsp; <%=autor%> | <a href="printme.asp?pid=<%=pid%>" target="_blank" class="sub">Для печати</a></p>
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
			<%if (usok) {%>
            <table width="100%" border="2" align="center" bordercolor="#FFFFFF">
              <tr> 
                <td height="2" bordercolor="#CCCCCC"> 
                  <div align="center"> 
                    <p><b>Публикация размещена в блоках:</b></p>
                  </div>
                </td>
              </tr>
              <tr> 
                <td height="21" bordercolor="#CCCCCC"> 
                  <p align="center"><font size="1" color="#0000FF"> 
                    <%
	  Records.Source="Select t2.id, t1.posit, t2.subj from news_pos t1, block_news t2 where t1.block_news_id=t2.id and t1.publication_id="+pid
	  Records.Open()
	  while (!Records.EOF ) {
		bnm=TextFormData(Records("SUBJ").Value,"")
		bpos=String(Records("POSIT").Value)
		bid=String(Records("ID").Value)
	  %>
                    &nbsp;<a href="block.asp?bk=<%=bid%>"><%=bnm%></a>&nbsp;(<%=bpos%>)<br>
                    <%
	 Records.MoveNext()
	  }
	  Records.Close()
	  %>
                    </font></p>
                </td>
              </tr>
            </table>
            <%}%>
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
    <td valign="top" align="right" width="73"><img src="images/flag_small.jpg" width="73" height="92"></td>
  </tr>
</table>
</body>
</html>
