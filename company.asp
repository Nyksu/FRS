<%@LANGUAGE="JScript"%>
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\getform.inc" -->
<!-- #include file="inc\err.inc" -->

<%
var admok=false

if (Session("is_adm_mem")==1) {admok=true}
if (Session("is_host")==1) {admok=true}

var name=""
var domen=""
var boss=""
var phone=""
var email=""
var city=""
var uadr=""
var padr=""
var fadr=""
var ind=""
var inn=""
var kpp=""
var rsch=""
var ksch=""
var okonh=""
var okpo=""
var bik=""
var bank=""
var divis=0
var admid=0
var admname=""


Records.Source="Select t1.*, t2.name as citnam from ENTERPRISE t1, CITY t2 where t1.ID="+company+" and t1.CITY_ID=t2.ID order by NAME"
Records.Open()
if (!Records.EOF) {
	name=String(Records("NAME").Value)
	domen=String(Records("DOMEN").Value)
	if (Records("BOSSFAM").Value!=null) {boss=Records("BOSSFAM").Value}
	if (Records("CITNAM").Value!=null) {city=Records("CITNAM").Value}
	if (Records("ADDRESS").Value!=null) {uadr=Records("ADDRESS").Value}
	if (Records("ADDRESS_F").Value!=null) {fadr=Records("ADDRESS_F").Value}
	if (Records("ADDRESS_P").Value!=null) {padr=Records("ADDRESS_P").Value}
	if (Records("POSTINDEX").Value!=null) {ind=Records("POSTINDEX").Value}
	if (Records("INN").Value!=null) {inn=Records("INN").Value}
	if (Records("KPP").Value!=null) {kpp=Records("KPP").Value}
	if (Records("KS").Value!=null) {ksch=Records("KS").Value}
	if (Records("RS").Value!=null) {rsch=Records("RS").Value}
	if (Records("OKONH").Value!=null) {okonh=Records("OKONH").Value}
	if (Records("OKPO").Value!=null) {okpo=Records("OKPO").Value}
	if (Records("BIK").Value!=null) {bik=Records("BIK").Value}
	if (Records("BANK").Value!=null) {bank=Records("BANK").Value}
	if (Records("BOSSIO").Value!=null) {boss=boss+" "+Records("BOSSIO").Value}
	phone=String(Records("PHONE").Value)
	if (Records("EMAIL").Value!=null) {email=Records("EMAIL").Value}
	admid=Records("USERS_ID").Value
} else {Response.Redirect("index.asp")}
Records.Close()

while (email.indexOf("@")>=0) {email=email.replace("@","<img src=\"pictograms/at.gif\" width=\"10\" height=\"16\">")}
%>
<html>
<head>
<title>Реквизиты <%=name%> - город <%=city%></title>
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
    <td width="300" align="center"><img src="images/flag_top.jpg" width="207" height="269" alt="<%=name%>"></td>
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
            <p><a href="/" class="menutop">Главная</a> 
              <img src="images/blue_dot.jpg" width="15" height="15" align="absmiddle"></p>
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
            <p><a  class="menutop"  href="message.asp">Обратная связь</a> <img src="images/blue_dot.jpg" width="15" height="15" align="absmiddle"></p>
          </td>
        </tr>
        <tr> 
          <td><img src="images/dot_hor.jpg" width="314" height="5"></td>
        </tr>
      </table>
      <table width="314" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30" align="right"> 
            <p><a  class="menutop"  href="company.asp"><font color="#CC0000">Реквизиты</font></a> 
              <img src="images/red_dot.jpg" width="15" height="15" align="absmiddle"></p>
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
            <h1><font color="#FFFFFF"><i>Наши реквизиты</i></font></h1>
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
          <td><% if (admok) {%><br>
<div align="center"> 
<p><a href="edcomp.asp" class="sub">Изменить реквизиты</a></p></div><%}%></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="90%"><table width="100%" border="1" bordercolor="#FFFFFF">
              <tr valign="top" bordercolor="#5A80AE"> 
                <td width="30%" align="right" bordercolor="#5A80AE" bgcolor="#EBF0F5"> 
                  <p>Начальник:</p>
                </td>
                  
                <td width="70%"> 
                  <p><%=boss%></p>
                </td>
              </tr>
                
              <tr valign="top" bordercolor="#5A80AE"> 
                <td width="30%" align="right" bordercolor="#5A80AE" bgcolor="#EBF0F5"> 
                  <p>Телефон:</p>
                </td>
                  
                <td width="70%"> 
                  <p><%=phone%></p>
                </td>
              </tr>
                
              <tr valign="top" bordercolor="#5A80AE"> 
                <td width="30%" align="right" bordercolor="#5A80AE" bgcolor="#EBF0F5"> 
                  <p>Домен:</p>
                </td>
                  
                <td width="70%"> 
                  <p><%=domen%></p>
                </td>
              </tr>
                
              <tr valign="top" bordercolor="#5A80AE"> 
                <td width="30%" align="right" bordercolor="#5A80AE" bgcolor="#EBF0F5"> 
                  <p>E-mail:</p>
                </td>
                  
                <td width="70%"> 
                  <p><%=email%></p>
                </td>
              </tr>
                
              <tr valign="top" bordercolor="#5A80AE"> 
                <td width="30%" align="right" bordercolor="#5A80AE" bgcolor="#EBF0F5"> 
                  <p> Юр.адрес:</p>
                </td>
                  
                <td width="70%"> 
                  <p><%=uadr%></p>
                </td>
              </tr>
                
              <tr valign="top" bordercolor="#5A80AE"> 
                <td width="30%" align="right" bordercolor="#5A80AE" bgcolor="#EBF0F5"> 
                  <p>Почтовый адрес:</p>
                </td>
                  
                <td width="70%"> 
                  <p><%=ind%>, город <%=city%>, <%=padr%></p>
                </td>
              </tr>
                
              <tr valign="top" bordercolor="#5A80AE"> 
                <td width="30%" align="right" bordercolor="#5A80AE" bgcolor="#EBF0F5"> 
                  <p>Адрес офиса:</p>
                </td>
                  
                <td width="70%"> 
                  <p><%=fadr%></p>
                </td>
              </tr>
                
              <tr valign="top" bordercolor="#5A80AE"> 
                <td width="30%" align="right" bordercolor="#5A80AE" bgcolor="#EBF0F5"> 
                  <p>ИНН / КПП:</p>
                    
                </td>
                  
                <td width="70%"> 
                  <p><%=inn%> / <%=kpp%></p>                </td>
              </tr>
            </table>
              
            <h3 align="left">Платежные реквизиты: </h3>
            <table width="100%" border="1" bordercolor="#FFFFFF">
              <tr valign="top" bordercolor="#5A80AE"> 
                <td width="30%" align="right" bordercolor="#5A80AE" bgcolor="#EBF0F5"> 
                  <p>Лицевой счет:</p>
                    
                </td>
                  
                <td bgcolor="#FFFFFF" width="70%"> 
                  <p><%=bank%></p>
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
    <td valign="top" align="right" width="73"><img src="images/flag_small.jpg" width="73" height="92"></td>
  </tr>
</table>
</body>
</html>
