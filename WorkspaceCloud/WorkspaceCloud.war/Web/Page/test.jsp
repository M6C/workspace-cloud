<%@ taglib uri="Framework_Taglib_Xml.tld" prefix="Xml" %>
<html>
	<head>
	</head>
	<body>
		<a href="/action.servlet?event=test&myID=joss&myPWD=seafrance">Exemple</a>
		<br>
		<Xml:TagXsl xml="WorkSpace_Security.xml" xsl="WorkSpace_Security.xsl">
			<Xml:TagXslParameter name="myID" value="#R$myID#"/>
			<Xml:TagXslParameter name="myPWD" value="#R$myPWD#"/>
			<Xml:TagXslResultDom name="resultDom" scope="request"/>
			<Xml:TagXslResultWrite/>
		</Xml:TagXsl>
<%--
		<br>
		<Xml:TagXml name="resultDom" scope="request" path="/ROOT/USER/PROFILES/PROFILE/APPLICATIONS/APPLICATION">
			<Xml:TagXmlValue path="@Name"/><br>
			<Xml:TagXml path="PATHS/PATH">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<Xml:TagXmlValue path="@Name"/>&nbsp;:&nbsp;
				<Xml:TagXmlValue path="."/><br>
			</Xml:TagXml>
		</Xml:TagXml>
--%>
	</body>
</html>