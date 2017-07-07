<%--
  Created by IntelliJ IDEA.
  User: rudeigerc
  Date: 2017/7/3
  Time: 09:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.mongodb.Notebook" %>
<%@ page import="model.mongodb.Note" %>
<%@ page import="model.mongodb.User" %>
<%
    Notebook notebook = (Notebook) request.getAttribute("notebook");
    ArrayList<Note> notes = (ArrayList<Note>) request.getAttribute("notes");
    ArrayList<User> collaborators = (ArrayList<User>) request.getAttribute("collaborators");
%>

<div class="row">
    <div class="col-md-2">
        <div style="padding-left: 24px;">
            <button type="button" class="btn btn-outline-secondary navbar-toggle offcanvas-toggle is-open" data-toggle="offcanvas" data-target="#left-sidebar" style="width: 45px; height: 45px; border: none;">
                <i class="fa fa-chevron-right" aria-hidden="true"></i>
            </button>
        </div>
    </div>
    <div class="col-md-8">
        <div class="container">
            <label for="editor"></label>
            <textarea name="editor" id="editor">

            </textarea>
            <footer>
                <p>&copy; 2017 TeamNote Team</p>
            </footer>
        </div>
    </div>
    <div class="col-md-2">
        <button class="button btn-outline-secondary navbar-toggle offcanvas-toggle" data-toggle="offcanvas" data-target="#right-sidebar" style="border: none; float: right; width: 60px;">
            <%
                for (User user : collaborators) {
            %>
            <img class="img-50px" src="<%=path%>/<%=user.getAvator()%>">
            <%
                }
            %>
            <i class="fa fa-commenting-o fa-2x" aria-hidden="true"></i>
        </button>
    </div>
</div>

<div class="modal fade" id="newNoteModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="newNoteModalTitle"></h4>
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                </button>
            </div>
            <div class="modal-body">
                <form role="form">
                        <label>笔记标题</label><input class="form-control" name="noteTitle">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
                <button type="button" class="btn btn-primary savenote">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="updateNoteModel" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="updateNoteModalTitle"></h4>
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                </button>
            </div>
            <div class="modal-body">
                <form role="form">
                    <label>更新说明</label><input class="form-control" name="message">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
                <button type="button" class="btn btn-primary savenote">保存</button>
            </div>
        </div>
    </div>
</div>

<nav class="navbar navbar-default" role="navigation">
    <div class="navbar-offcanvas navbar-offcanvas-touch navbar-offcanvas-fade in" id="left-sidebar">
        <div class="pre-scrollable" id="left-sidebar-nav">
            <img class="img-75px" src="<%=path%>/<%=notebook.getCover()%>" style="margin-top: 15px; ">
            <button type="button" class="btn btn-outline-secondary btn-back navbar-toggle offcanvas-toggle" data-toggle="offcanvas" data-target="#left-sidebar">
                <i class="fa fa-chevron-left" aria-hidden="true"></i>
            </button>
            <br><br>
            <%
                if (notes != null) {
            %>
            <h5 class="card-title notebook" id="<%=notebook.getNotebookId()%>">
                <%=notebook.getTitle()%>
            </h5>
            <ul style="padding-left: 0;">
            <%
                    for (Note note : notes) {
                        int id = note.getNoteId();
            %>
                <li class="bar-note">
                    <a class="note" :class="{ 'active': <%=id%> === selected }" @click="select(<%=id%>)" id="<%=id%>"
                       style="margin-left: 10px;" href="javascript:void(0)"><%=note.getTitle()%></a>
                </li>
            <%
                    }
                }
            %>
            </ul>
        </div>
        <div class="dropdown-divider"></div>
        <div class="sidebar-btn">
            <button class="btn btn-outline-danger" data-toggle="modal" data-target="#giveOwnershipModal" style="padding: 8px">
                转让所有权
            </button>
            <button class="btn btn-outline-primary">邀请用户</button>
            <button class="btn btn-outline-warning">审核</button>
            <button class="btn btn-outline-primary" id="newNote">新建笔记</button>
            <button class="btn btn-outline-success" data-toggle="modal" data-target="#historyModal">
                历史记录
            </button>
            <button class="btn btn-outline-primary">设置</button>
            <button class="btn btn-danger">取消</button>
            <button class="btn btn-success" id="callDialog">保存</button>
        </div>
    </div>
</nav>

<nav class="navbar navbar-default" role="navigation">
    <div class="navbar-offcanvas navbar-offcanvas-touch navbar-offcanvas-fade navbar-offcanvas-right" id="right-sidebar">
        <div class="pre-scrollable">

        </div>
    </div>
</nav>

<div class="modal fade" id="giveOwnershipModal" tabindex="-1" role="dialog" aria-labelledby="giveOwnershipModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="giveOwnershipModalLabel" style="color: #D0021B">
                    <i class="fa fa-exchange" aria-hidden="true"></i>&nbsp;转让所有权
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                ...
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="giveOwnership">确认</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="historyModal" tabindex="-1" role="dialog" aria-labelledby="historyModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="historyModalLabel">
                    <i class="fa fa-history" aria-hidden="true"></i>&nbsp;历史记录
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                ...
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary">确认</button>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp"%>
<script type="text/javascript" src="<%=path%>/js/bootstrap.offcanvas.js"></script>
<script type="text/javascript" src="https://cdn.ckeditor.com/4.7.1/full/ckeditor.js"></script>
<script type="text/javascript" src="<%=path%>/js/cooperate.js"></script>
<script type="text/javascript">
    CKEDITOR.replace( 'editor', {
        customConfig: '<%=path%>/ckeditor/js/config.js',
        contentsCss: '<%=path%>/ckeditor/css/contents.css',
        skin: 'bootstrapck,<%=path%>/ckeditor/skins/bootstrapck/'
    } );

    var note = new Vue({
        el: '#left-sidebar',
        data: {
            selected: null
        },
        methods: {
            select: function(id) {
                this.selected = id;
            }
        }
    });

    window.onbeforeunload = function() {
        return "";
    };
</script>