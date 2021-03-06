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
<style type="text/css">
    body {
        overflow: hidden;
    }
</style>

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
            <textarea name="editor" id="editor"></textarea>
            <footer>
                <p>&copy; 2017 TeamNote Team</p>
            </footer>
        </div>
    </div>
    <div class="col-md-2">
        <button class="button btn-outline-secondary navbar-toggle offcanvas-toggle" id="showChat" data-toggle="offcanvas" data-target="#right-sidebar" style="border: none; float: right; width: 60px;">
            <%
                for (User user : collaborators) {
            %>
            <img class="img-50px rounded" src="<%=path%>/<%=user.getAvatar()%>">
            <%
                }
            %>
            <i class="fa fa-commenting-o fa-2x" id="chat_icon" aria-hidden="true"></i>
        </button>

    </div>
</div>

<!-- left sidebar -->
<nav class="navbar navbar-default" role="navigation">
    <div class="navbar-offcanvas navbar-offcanvas-touch navbar-offcanvas-fade in" id="left-sidebar">
        <div class="pre-scrollable" id="left-sidebar-nav" style="padding-right: 10px;">
            <img class="img-75px rounded" src="<%=path%>/<%=notebook.getCover()%>" style="margin-top: 15px; ">
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
                <li class="bar-note" style="padding-left: 10px; margin-top: 5px; margin-bottom: 5px;">
                    <a class="note" :class="{ 'active': <%=id%> === selected }" @click="select(<%=id%>)" id="<%=id%>"
                       style="word-break: break-all;" href="javascript:void(0)"><%=note.getTitle()%></a>
                    <div class="btn-group btn-group-sm pull-right" role="group" aria-label="functional-button">
                        <button type="button" class="btn btn-secondary none btn-edit" data-toggle="modal" data-target="#editModal" >
                            <i class="fa fa-pencil fa-fw" aria-hidden="true"></i>
                        </button>
                        <button type="button" class="btn btn-secondary none btn-delete">
                            <i class="fa fa-trash-o fa-fw" aria-hidden="true"></i>
                        </button>
                        <button type="button" class="btn btn-secondary none btn-history">
                            <i class="fa fa-history fa-fw" aria-hidden="true" data-toggle="modal" data-target="#historyModal"></i>
                        </button>
                        <button type="button" class="btn btn-secondary none btn-suggestion">
                            <i class="fa fa-street-view fa-fw" aria-hidden="true" data-toggle="modal" data-target="#suggestionModal"></i>
                        </button>
                    </div>
                </li>
            <%
                    }
                }
            %>
            </ul>
        </div>
        <div class="dropdown-divider"></div>
        <div class="sidebar-btn">
            <button class="btn btn-outline-warning" id="giveOwnership" style="padding: 8px">转让所有权</button>
            <button class="btn btn-outline-primary" id="inviteCollaborator">邀请用户</button>
            <button class="btn btn-secondary" id="newNote">新建笔记</button>
            <button class="btn btn-outline-primary" id="config" data-toggle="modal" data-target="#configModal">设置</button>
            <button class="btn btn-danger">取消</button>
            <button class="btn btn-success" id="callDialog">保存</button>
            <button class="btn btn-outline-success" style="display:none" id="chooseType">导出</button>
            <button class="btn btn-outline-success" id="uploadNote">导入</button>
        </div>
    </div>
</nav>

<!-- right sidebar -->
<nav class="navbar navbar-default" role="navigation">
    <div class="navbar-offcanvas navbar-offcanvas-touch navbar-offcanvas-fade navbar-offcanvas-right" id="right-sidebar">
        <div class="pre-scrollable" id="chatbox" style="max-height: 70%;">
            <div class="panel panel-primary" style="width: 100%; height: 70%;">
                <div class="panel-body" id="chatContent"></div>
            </div>
        </div>
        <div class="dropdown-divider" style="margin-bottom: 0;"></div>
        <div>
            <button type="button" class="btn btn-outline-secondary btn-back navbar-toggle offcanvas-toggle"
                    data-toggle="offcanvas" data-target="#right-sidebar" style="width: auto; height: auto;">
                <i class="fa fa-chevron-right" aria-hidden="true"></i>
            </button>
            <label for="msg"></label>
            <textarea rows="4" class="form-control" id="msg"></textarea>
            <input type="hidden" class="btn btn-outline-primary" value="发送" id="sendMsg">
            <!-- <input type="button" class="btn btn-secondary" value="清空" id="clearMsg"> -->
        </div>
    </div>
</nav>

<!-- notebook related modals -->
<!-- giveOwnershipModal -->
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
                <form role="form">
                    <div class="form-group">
                        <label for="newOwner" class="form-control-label">新拥有者</label>
                        <input class="form-control" name="newOwner" id="newOwner">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary giveOwnership">确认</button>
            </div>
        </div>
    </div>
</div>
<!-- /giveOwnershipModal -->

<!-- configModal -->
<div class="modal fade" id="configModal" tabindex="-1" role="dialog" aria-labelledby="configModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="configModalLabel">
                    <i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;笔记本设置
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form role="form">
                    <div class="form-group">
                        <label for="noteTitle" class="form-control-label">笔记本标题</label>
                        <input type="text" class="form-control" id="noteTitle">
                    </div>
                    <div class="form-group">
                        <label for="noteDescription" class="form-control-label">笔记简介</label>
                        <input type="text" class="form-control" id="noteDescription">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="config-confirm">确认</button>
            </div>
        </div>
    </div>
</div>
<!-- /configModal -->

<!-- newNoteModal -->
<div class="modal fade" id="newNoteModal" tabindex="-1" role="dialog" aria-labelledby="newNoteModalTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="newNoteModalTitle"></h4>
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span><span class="sr-only"></span>
                </button>
            </div>
            <div class="modal-body">
                <form role="form">
                    <div class="form-group">
                        <label for="noteTitle-new" class="form-control-label">笔记标题</label>
                        <input class="form-control" name="noteTitle" id="noteTitle-new">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
                <button type="button" class="btn btn-primary savenote">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- /newNoteModal -->

<!-- updateNoteModal -->
<div class="modal fade" id="updateNoteModal" tabindex="-1" role="dialog" aria-labelledby="updateNoteModalTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="updateNoteModalTitle"></h4>
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span><span class="sr-only"></span>
                </button>
            </div>
            <div class="modal-body">
                <form role="form">
                    <div class="form-group">
                        <label for="message" class="form-control-label">更新说明</label>
                        <input class="form-control" name="message" id="message">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
                <button type="button" class="btn btn-primary savenote">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- /updateNoteModal -->

<!-- inviteCollaboratorModal -->
<div class="modal fade" id="inviteCollaboratorModal" tabindex="-1" role="dialog" aria-labelledby="inviteCollaboratorModalTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="inviteCollaboratorModalTitle"></h4>
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span><span class="sr-only"></span>
                </button>
            </div>
            <div class="modal-body">
                <form data-toggle="validator" role="form">
                    <div class="form-group has-feedback">
                        <label for="inviteUsername" class="form-control-label">邀请用户</label>
                        <span class="fa form-control-feedback" aria-hidden="true"></span>
                        <input class="form-control" name="inviteUsername" id="inviteUsername" data-remote="<%=path%>/cooperate/inviteValidate" data-error="被邀请的用户不存在">
                        <div class="help-block with-errors text-danger"></div>
                    </div>
                    <div class="form-group">
                        <label for="inviteDescription" class="form-control-label">验证消息</label>
                        <input class="form-control" name="inviteDescription" id="inviteDescription">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
                <button type="button" class="btn btn-primary invite">邀请</button>
            </div>
        </div>
    </div>
</div>
<!-- /inviteCollaboratorModal -->

<!-- exportModal -->
<div class="modal fade" id="exportModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="exportModalTitle"></h4>
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span><span class="sr-only"></span>
                </button>
            </div>
            <div class="modal-body">
                <label for="exportType">文件格式</label>
                <select class="form-control" id="exportType">
                    <option value="html">html</option>
                    <option value="pdf">pdf</option>
                    <option value="md">md</option>
                </select>
                <label for="exportContent">导出内容</label>
                <select class="form-control" id="exportContent">
                    <option value="note">当前笔记</option>
                    <option value="notebook">该笔记本中的所有笔记</option>
                </select>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
                <button type="button" class="btn btn-primary export">下载</button>
            </div>
        </div>
    </div>
</div>
<!-- /exportModal -->

<!-- uploadModal -->
<div class="modal fade" id="uploadModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="uploadModalTitle"></h4>
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span><span class="sr-only"></span>
                </button>
            </div>
            <form id="uploadForm">
                <div class="modal-body">
                    <label class="form-control-label">本地文件:</label>
                    <input type="file" name="uploadFile"/>
                    <input style="display:none" type="text" name="notebookId" value="<%=notebook.getNotebookId()%>">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
                    <button type="button" class="btn btn-primary" id="upload">上传</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- /uploadModal -->

<!-- note related modals -->
<!-- uploadImageModal -->
<div class="modal fade" id="uploadImageModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="uploadImageModalTitle">选择图片</h4>
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span><span class="sr-only"></span>
                </button>
            </div>
            <form id="uploadImageForm">
                <div class="form-group">
                    <div class="modal-body">
                        <div class="form-group">
                            <img src="" id="avatar" class="img-150px">
                            <br>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-secondary file-chooser-label" id="file_upload_label" style="margin-top: 0;">选择上传的图片
                                    <input type="file" class="form-control-file file-chooser" id="Image" name="Image">
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
                    <button type="button" class="btn btn-primary" id="uploadImage">确定</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- /uploadImageModal -->
<!-- editModal -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">
                    <i class="fa fa-pencil" aria-hidden="true"></i>&nbsp;编辑笔记标题
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form role="form">
                    <div class="form-group">
                        <label for="noteTitle-edit" class="form-control-label">笔记标题</label>
                        <input type="text" class="form-control" id="noteTitle-edit">
                    </div>
                    <div class="form-group">
                        <input type="hidden" class="form-control" id="noteId-edit">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary btn-edit-confirm">确认</button>
            </div>
        </div>
    </div>
</div>
<!-- /editModal -->

<!-- historyModal -->
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
                <div class="list-group">
                    <input type="hidden" id="noteId" value="">
                    <div v-for="(_history, index) in history">
                        <a class="list-group-item list-group-item-action flex-column align-items-start"
                           :href="'#history_collapse_' + index" data-toggle="collapse" aria-expanded="false" :aria-controls="'history_collapse_' + index" :key="index">
                            <div class="d-flex w-100 justify-content-between">
                                <h5 class="mb-1">
                                    <i class="fa fa-user-o" aria-hidden="true"></i>&nbsp;{{ _history.editor }}
                                </h5>
                                <small>{{ _history.editTime }}</small>
                            </div>
                            <p class="mb-1">{{ _history.message }}</p>
                        </a>
                        <div class="collapse" :id="'history_collapse_' + index">
                            <div class="card card-block">
                                {{ _history.content }}
                                <div class="dropdown-divider"></div>
                                <div style="text-align: right;">
                                    <button type="button" class="btn btn-outline-warning btn-switch" @click="switchVersion">切换版本</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /historyModal -->

<!-- suggestionModal -->
<div class="modal fade" id="suggestionModal" tabindex="-1" role="dialog" aria-labelledby="suggestionModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="suggestionModalLabel">
                    <i class="fa fa-street-view" aria-hidden="true"></i>&nbsp;建议审查
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="list-group">
                    <input type="hidden" id="_noteId" value="">
                    <div v-for="(_suggestion, index) in suggestion">
                        <a class="list-group-item list-group-item-action flex-column align-items-start"
                           :href="'#suggestion_collapse_' +  _suggestion.suggestionId" data-toggle="collapse" aria-expanded="false" :aria-controls="'suggestion_collapse_' +  _suggestion.suggestionId" :key="index">
                            <div class="d-flex w-100 justify-content-between">
                                <h5 class="mb-1">
                                    <i class="fa fa-user-o" aria-hidden="true"></i>&nbsp;{{ _suggestion.username }}
                                </h5>
                                <small>{{ _suggestion.raiseTime }}</small>
                            </div>
                            <p class="mb-1">{{ _suggestion.issue }}</p>
                        </a>
                        <div class="collapse" :id="'suggestion_collapse_' + _suggestion.suggestionId">
                            <div class="card card-block">
                                {{ _suggestion.content }}
                                <div class="dropdown-divider"></div>
                                <div style="text-align: right;">
                                    <button type="button" class="btn btn-outline-secondary btn-ignore" @click="ignoreSuggestion">忽略建议</button>
                                    <button type="button" class="btn btn-outline-warning btn-merge" @click="mergeSuggestion">合并建议</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- suggestionModal -->

<%@ include file="footer.jsp"%>
<script type="text/javascript" src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/bootstrap.offcanvas.js"></script>
<script type="text/javascript" src="<%=path%>/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="<%=path%>/js/validator.js"></script>
<script type="text/javascript" src="<%=path%>/js/cooperate.js"></script>
<script type="text/javascript">

    CKEDITOR.replace( 'editor', {
        customConfig: '<%=path%>/ckeditor/config.js',
        height: 600
    });

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

    $('#historyModal').on('hidden.bs.modal', function() {
        $(this).removeData('bs.modal');
    });

    //window.onbeforeunload = function() {
        //return "";
    //};
</script>