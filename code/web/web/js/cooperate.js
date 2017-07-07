/**
 * Created by rudeigerc on 2017/7/4.
 */
var noteId = -1;
$(document).ready(function() {
    $('.giveOwnership').click(function() {
        var notebookId = $('.notebook').attr('id');
        var newOwnerName = $('input[name="newOwner"]').val();
        var confirm = window.confirm("警告: 所有权转让后无法还原");
        if (!confirm) return;
        $.ajax({
            url: "/teamnote/cooperate/giveownership",
            processData: true,
            dataType: "text",
            data: {
                newOwnerName : newOwnerName,
                notebookId : notebookId
            },
            success: function(data) {
                var json = JSON.parse(data);
                if (json.result === "success") {
                    alert(json.newOwner + " 已被钦定为新的拥有者");
                }
                else {
                    alert("你不是笔记本所有者，无法转让所有权");
                }
                $('#giveOwnershipModal').modal('hide');
            }
        });
    });

    $('#giveOwnership').click(function () {
        $('input[name="newOwner"]').val("");
        $('#giveOwnershipModal').modal('show');
    });

    $('#callDialog').click(function () {
        if (noteId === -1) {
            $('#newNoteModalTitle').html("添加标题");
            $('input[name="noteTitle"]').val("");
            $('#newNoteModal').modal('show');
        }
        else {
            $('#updateNoteModalTitle').html("更新笔记");
            $('input[name="message"]').val("");
            $('#updateNoteModal').modal('show');
        }
    });

    $('.savenote').click(function () {
        var content = CKEDITOR.instances.editor.getData();
        var notebookId = $('.notebook').attr('id');
        if (noteId === -1) {
            var noteTitle = $('input[name="noteTitle"]').val();
            $.ajax({
                url : "/teamnote/saveFirstEdition",
                processData : true,
                dataType : "text",
                type : "post",
                data : {
                    notebookId : notebookId,
                    noteTitle : noteTitle,
                    content : content
                },
                success : function(data) {
                    var json = JSON.parse(data);
                    if (json.result === "success")
                        location.reload();
                    else {
                        alert("error in adding note");
                    }
                }
            });
            $('#modal').modal('hide');
        }
        else {
            var message = $('input[name="message"]').val();
            $.ajax({
                url : "/teamnote/updateNote",
                processData : true,
                dataType : "text",
                type : "post",
                data : {
                    noteId : noteId,
                    content : content,
                    message : message
                },
                success : function(data) {
                    var json = JSON.parse(data);
                    if (json.result === "success")
                        location.reload();
                    else {
                        alert("error in updating note");
                    }
                }
            });
            $('#modal').modal('hide');
        }
    });

    $(".note").click(function(e) {
        noteId = parseInt(e.target.id);
        $.ajax({
            url : "/teamnote/getNote",
            processData : true,
            dataType : "text",
            type : "post",
            data : {
                noteId : noteId
            },
            success : function(data) {
                var json = JSON.parse(data);
                CKEDITOR.instances.editor.setData(json.content);
            }
        });
    });

    $("#newNote").click(function() {
        noteId = -1;
        CKEDITOR.instances.editor.setData("");
    });

    $("#inviteCollaborator").click(function () {
        $('#inviteCollaboratorModalTitle').html('邀请用户');
        $('input[name="inviteUsername"]').val("");
        $('input[name="inviteDescription"]').val("");
        $('#inviteCollaboratorModal').modal('show');
    });

    $(".invite").click(function() {
        var inviteUsername = $('input[name="inviteUsername"]').val();
        var inviteDescription = $('input[name="inviteDescription"]').val();
        var notebookId = $('.notebook').attr('id');
        console.log(notebookId);
        $.ajax({
            url : "/teamnote/cooperate/invite",
            processData : true,
            dataType : "text",
            type : "post",
            data : {
                inviteUsername : inviteUsername,
                inviteDescription : inviteDescription,
                notebookId : notebookId
            },
            success : function (data) {
                console.log(data);
                var json = JSON.parse(data);
                if (json.result === "success") {
                    $('#inviteCollaboratorModal').modal('hide');
                    alert("请求已发送，等待对方接受邀请");
                }
                else {
                    $('#inviteCollaboratorModal').modal('hide');
                    alert("请求发送失败");
                }
            }
        });
    });
});