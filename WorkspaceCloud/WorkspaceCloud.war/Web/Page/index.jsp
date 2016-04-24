<html>
    <head>
        <title>
            Index
        </title>
            <link href="/css/page/index.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="/js/page/index.js" type="text/javascript"></script>
    </head>
    <body bgcolor="#ffffff" onload="setFocus()">
            <form name="formLogin" action="action.servlet" method="post">
                <input type="hidden" name="event" value="IndexLoginValider"/>
                <table width="100%">
                    <hr>
                        <td align="center">
                            <h2><b>Authentification</b></h2>
                        </td>
                    </hr>
                </table>
                <table align="center">
                    <tr>
                        <td>
                            Login&nbsp;
                        </td>
                        <td>
                            <input type="text" name="login"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Password&nbsp;
                        </td>
                        <td>
                            <input type="password" name="password"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                </table>
                <table width="100%">
                    <hr>
                        <td align="center">
                            <input type="submit" value="Connect"/>
                        </td>
                    </hr>
                </table>
            </form >
    </body>
</html>
