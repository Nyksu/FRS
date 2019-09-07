<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\creaters.inc" -->
<!-- #include file="inc\getform.inc" -->
<!-- #include file="inc\err.inc" -->
<!-- #include file="inc\email.inc" -->


<%
var ErrorMsg=""
var text=""
var name=""


Records.Source="Select * from enterprise where ID="+company
Records.Open()
   if (Records.EOF){
	Records.Close()
	Response.Redirect("index.asp")
   }
// Здесь в переменной namcomp наименование фирмы. Можно где-нить использовать если надо...
namcomp=String(Records("NAME").Value)
Records.Close()

var eml=Server.CreateObject("JMail.Message")
eml.Logging=true
eml.From=fromaddres
eml.AddRecipient(Recipient)
eml.Subject=Subject
eml.Charset=characterset
eml.ContentTransferEncoding = "base64"

var isSending=false

isFirst=String(Request.Form("Submit"))=="undefined"
ShowForm=true
if(!isFirst){
	
		//-------------input validation-----------
		fio=TextFormData(Request.Form("Name"),"")
		Company=TextFormData(Request.Form("company"),"")
		Phone=TextFormData(Request.Form("Phone"),"")
		Email=TextFormData(Request.Form("email"),"")
		Text=TextFormData(Request.Form("txt"),"")


		if(Text.length>2000){ErrorMsg+="Сообщение превышает допустимый размер.<br>"}
		if(Text.length<4){ErrorMsg+="Сообщение отсутствует.<br>"}
		if ((Phone == "") && (Email == "")) {ErrorMsg=ErrorMsg+"Либо поле 'E-mail' либо поле 'Телефон' должны быть обязательно заполнены.<br>"}
		if(fio ==""){ErrorMsg+="Поле 'Ф.И.О.' должно быть заполнено.<br>"}
		if ((Email != "") && (!/(\w+)@((\w+).)*(\w+)$/.test(Email))) {ErrorMsg=ErrorMsg+"Неверный формат поля 'E-mail'.<br>"}
		

		if (ErrorMsg==""){
			
			try{
				eml.FromName=fromname+fio
				eml.AppendText("Сообщение с сайта FRS.72RUS.RU \n")
				eml.AppendText(" Ф.И.О. : "+fio+"\n")
				eml.AppendText(" Компания : "+Company+"\n")
				eml.AppendText(" Телефон : "+Phone+"\n")
				eml.AppendText(" Email : "+Email+"\n")
				eml.AppendText("\n Сообщение : \n \n")
				eml.AppendText(TextFormData(Request.Form("txt")))
				isSending=eml.Send(servsmtp)
	 			if (isSending) {ShowForm=false}
			}
			catch(e){
				ErrorMsg+="Проблемы с почтой.<br>"
			}
		} else {
			
			
		}

	
}

%>
<html>
<head>
<title>E-mail <%=namcomp%></title>
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
    <td width="300" align="center"><img src="images/flag_top.jpg" width="207" height="269" alt="<%=namcomp%>"></td>
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
                  <a href="/" class="sub">FRS.72RUS.RU</a> / Обратная связь</td>
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
              <li class="menutop"><a href="/" class="menutop">Главная</a> </li>
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
              <li  class="red"><a  class="red"  href="message.asp">Обратная 
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
            <h1><font color="#FFFFFF"><i>Задайте Ваш вопрос по E-mail</i></font></h1>
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
          <td>&nbsp;</td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="90%" align="center"> 
            <%if(ErrorMsg!=""){%>
            <h3><font color="#FF3300">Ошибка!</font><br>
              <%=ErrorMsg%></h3>
            <%}%>
            <form name="Guest" method="post" action="message.asp">
              <%if(ShowForm){%>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr valign="middle"> 
                  <td width="160" align="right" height="30"> 
                    <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Ваше 
                      имя: </font></p>
                  </td>
                  <td height="30"> 
                    <input type="text" name="Name" value="<%=isFirst?"":Request.Form("name")%>" size="50" maxlength="50">
                  </td>
                </tr>
                <tr valign="middle"> 
                  <td width="160" align="right" height="32"> 
                    <p><FONT FACE="Verdana, Arial, Helvetica, sans-serif" SIZE="2">Организация:</FONT></p>
                  </td>
                  <td height="32"> 
                    <input type="text" name="company" value="<%=isFirst?"":Request.Form("company")%>" size="50" maxlength="100">
                  </td>
                </tr>
                <tr valign="middle"> 
                  <td width="160" align="right" height="32"> 
                    <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Контактный 
                      телефон:</font></p>
                  </td>
                  <td height="32"> 
                    <input type="text" name="phone" value="<%=isFirst?"":Request.Form("phone")%>" size="50" maxlength="50">
                  </td>
                </tr>
                <tr valign="middle"> 
                  <td width="160" align="right" height="32"> 
                    <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Ваш 
                      e-mail:</font></p>
                  </td>
                  <td height="32"> 
                    <input type="text" name="email" value="<%=isFirst?"":Request.Form("email")%>" size="50" maxlength="50">
                  </td>
                </tr>
                <tr> 
                  <td width="160" align="right" valign="top" height="144"> 
                    <p><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Текст 
                      сообщения:</font></p>
                  </td>
                  <td height="144"> 
                    <textarea name="txt" cols="50" rows="8"><%=text%></textarea>
                  </td>
                </tr>
                <tr> 
                  <td width="160" align="right" valign="top" height="32">&nbsp;</td>
                  <td height="32"> 
                    <input type="submit" name="Submit" value="Переслать">
                    <input type="reset" name="Submit2" value="Очистить">
                  </td>
                </tr>
              </table>
              <%}else{%>
<p>Спасибо! Ваше сообщение отправлено.<br>
<a href="/">На главную страницу</a></p>
<%}%>
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
