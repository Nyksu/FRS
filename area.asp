<%@LANGUAGE="JAVASCRIPT"%>
<!-- #include file="inc\records.inc" -->
<!-- #include file="inc\getform.inc" -->
<!-- #include file="inc\err.inc" -->

<%

if ((Session("is_adm_mem")!=1)&&(Session("is_host")!=1)){
Session("backurl")="area.asp"
Response.Redirect("login.asp")
}

%>


<html>
<head>
<title>����������������� �����.</title>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
<link rel="stylesheet" href="style.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr bgcolor="#000000"> 
    <td width="300"> 
      <p><a href="http://www.rusintel.ru"><font color="#FFFFFF"><b>������� ��������������</b></font></a> 
        / <a href="index.asp"><b><font color="#FFFFFF"> </font></b></a></p>
    </td>
    <td align="RIGHT">&nbsp;
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr  bgcolor="#333333"> 
    <td valign="middle" width="500"> 
      <p>&nbsp;</p>
    </td>
    <td  bgcolor="#333333" align="right">&nbsp; 
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr  bgcolor="#333333"> 
    <td valign="middle" width="500" bgcolor="#FFFFFF"> 
      <p>&nbsp; </p>
    </td>
    <td bgcolor="#FFFFFF" align="right"> <font></font> 
      <p><font color="#990000"><b>������� ��������������</b></font></p>
    </td>
  </tr>
</table>
<table width="100%" border="1"> <tr> <td bordercolor="#333333"> <div align="left"> 
<p><font color="#0000CC"><b>������������, <%=Session("name_mem")%> !</b></font></p></div></td></tr> 
</table><table width="100%" border="1"> <tr bordercolor="#333333" bgcolor="#CCCCCC"> 
<td width="50%"> <div align="center"> <p><b>����������</b></p></div></td><td width="50%"> 
<div align="center"> <p><b>�����������</b></p></div></td></tr> <tr bordercolor="#333333" valign="top"> 
<td width="50%"> <ul> <li> <p><a href="pswusr.asp?usr=<%=Session("id_mem")%>">�������� 
������</a></p></li><li> <p><a href="index.asp">������������� ����</a></p></li></ul></td><td width="50%"> 
<ul> <li> <p><a href="edcomp.asp">�������� ������ �� �����������</a></p></li><LI> 
<P><A HREF="bloknews.asp">�������������� �����</A></P></LI><LI><P><A HREF="pubarea.asp">������������� 
�������������� ���������</A></P></LI></ul></td></tr> </table>
<div align="center"> 
  <p>&nbsp;</p>
  <p><font color="#FFFFFF"><a href="index.asp">�� ������� ��������</a></font></p>
  
</div>
</body>
</html>
