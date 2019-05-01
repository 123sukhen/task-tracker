package com.fse.tasktracker;

import java.util.List;

public interface TaskService {

    Task finishTask(int id);//will be called during finish task

    List<Task> getTaskdetails();

    Task findByTaskId(int id);

    Task updateTask(Task task);

    Task deleteTask(int id);

    Task createUser(Task task);
}
