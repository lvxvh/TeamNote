<%--
  Created by IntelliJ IDEA.
  User: rudeigerc
  Date: 2017/7/11
  Time: 16:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <%
            String path = request.getContextPath();
        %>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>TeamNote - 403</title>
        <meta name="author" content="TeamNote Team">
        <meta name="description" content="A platform for people to share and create notes together.">
        <link rel="icon" href="<%=path%>/icon/favicon.png">
        <link type="text/css" rel="stylesheet" href="<%=path%>/css/teamnote.css"/>
    </head>
    <body>
        <div id="particles-js">
            <div class="container container-center">
                <img src="<%=path%>/icon/favicon-200px-error.png">
                <h1 style="text-align: center;">403 FORBIDDEN</h1>
                <div>
                    <h5 style="text-align: center;">如果您有任何疑问，请联系<a href="mailto:rudeigerc@gmail.com" style="text-decoration: none; color: inherit;">管理员</a>。</h5>
                </div>
            </div>
        </div>
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
        <script type="text/javascript" src="<%=path%>/js/validator.js"></script>
        <script type="text/javascript">
            particlesJS.load('particles-js', 'json/particles-error.json', function() {
                console.log('callback - particles.js config loaded');
            });
        </script>
    </body>
</html>
