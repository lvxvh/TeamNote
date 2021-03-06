package service;

import java.io.File;
import java.io.IOException;
import java.util.Date;

/**
 * Created by qjr on 2017/6/27.
 */
public interface CreateNoteService {
    /**
     * createNotebook
     * @param userId 创建者Id
     * @param notebookName 笔记本名称
     * @return 新建笔记Id, -1为失败
     */
    int createNotebook(int userId, String notebookName);

    /**
     * uploadFileNote
     * @param userId 上传者Id
     * @param notebookId 笔记本Id
     * @param content 上传的文件内容（二进制文件）
     * @param datetime 上传时间
     * @return 1为成功，0为失败
     */
    int uploadFileNote(int userId, int notebookId, File content, Date datetime) throws IOException;

    /**
     * uploadTextNote
     * @param userId 上传者userId
     * @param notebookId 笔记本Id
     * @param noteTitle 笔记本Title
     * @param content 上传的文件内容（文本文件）
     * @param datetime 上传时间
     * @return 1为成功，0为失败
     */
    int newTextNote(int userId, int notebookId, String noteTitle, String content, Date datetime) throws IOException;
}

