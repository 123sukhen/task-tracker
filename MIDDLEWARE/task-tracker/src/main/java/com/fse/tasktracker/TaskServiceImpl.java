package com.fse.tasktracker;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Service
public class TaskServiceImpl implements TaskService {

    Logger logger= LoggerFactory.getLogger(TaskServiceImpl.class);

    @PersistenceContext
    private EntityManager manager;

    @Override
    public Task finishTask(int id) {
        Task finishTask=null;
        try{
         finishTask = manager.createNamedQuery("callFinishTask", Task.class).setParameter(1, id).getSingleResult();
        return finishTask;}
        catch(Exception ex){
            logger.error("Issue in TaskServiceImpl"+ex.getMessage());
        }
        return finishTask;
    }

    @Override
    public List<Task> getTaskdetails() {
        List<Task> taskDetails=null;
        try{
            taskDetails = manager.createNamedQuery("callGetAllTasks", Task.class).getResultList();
           return taskDetails;}
        catch(Exception ex){
               logger.error("Issue in TaskServiceImpl"+ex.getMessage());
           }
           return taskDetails;
    }

    @Override
    public Task findByTaskId(int id) {
        Task taskDetails=null;
        try{
            taskDetails = manager.createNamedQuery("callSpecificTask", Task.class).setParameter(1, id).getSingleResult();
        return taskDetails;}

          catch(Exception ex){
            logger.error("Issue in TaskServiceImpl"+ex.getMessage());
        }
        return taskDetails;
    }

    @Override
    public Task updateTask(Task task) {
        Task taskDetails=null;
        try{ taskDetails = manager.createNamedQuery("callUpdateSpecificTask", Task.class).setParameter(1, task.getTask_id())
                .setParameter(2, task.getTask())
                .setParameter(3, task.getStart_date())
                .setParameter(4, task.getEnd_date())
                .setParameter(5, task.getPriority())
                .setParameter(6, task.getParent_task())
                .getSingleResult();
        return taskDetails;}
          catch(Exception ex){
            logger.error("Issue in TaskServiceImpl"+ex.getMessage());
        }
        return taskDetails;
    }

    @Override
    public Task deleteTask(int id) {
        Task taskDetails=null;
        try{
            taskDetails = manager.createNamedQuery("callDeleteSpecificTask", Task.class)
                .setParameter(1, id).getSingleResult();
        return taskDetails;}
          catch(Exception ex){
        logger.error("Issue in TaskServiceImpl"+ex.getMessage());
    }
        return taskDetails;
    }

    @Override
    public Task createUser(Task task) {
        Task taskDetails=null;
        try{
            taskDetails = manager.createNamedQuery("callInsertSpecificTask", Task.class)
                .setParameter(1, task.getTask())
                .setParameter(2, task.getStart_date())
                .setParameter(3, task.getEnd_date())
                .setParameter(4, task.getPriority())
                .setParameter(5, task.getParent_task())
                .getSingleResult();
        return taskDetails;}
          catch(Exception ex){
            logger.error("Issue in TaskServiceImpl"+ex.getMessage());
        }
        return taskDetails;
    }
}
