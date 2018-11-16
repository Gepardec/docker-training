package com.gepardec.examples.todowildflyswarm.controller;

import com.gepardec.examples.todowildflyswarm.persistence.dao.TodoRepository;
import com.gepardec.examples.todowildflyswarm.persistence.model.Todo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.enterprise.inject.Model;
import javax.inject.Inject;
import java.util.List;

@Model
public class TodoController {

    private static final Logger logger = LoggerFactory.getLogger(TodoController.class);

    @Inject
    private TodoRepository todoRepository;

    private List<Todo> todos;
    private String todo = "";

    public void loadData() {
        todos = todoRepository.findAll();
    }

    public List<Todo> getTodos() {
        loadData();
        logger.info("Todo: {}", todos);
        return todos;
    }

    public String getTodo() {
        return todo;
    }

    public void setTodo(String todo) {
        this.todo = todo;
    }

    public void save() {
        Todo todo = new Todo();
        todo.setName(this.todo);
        todoRepository.save(todo);
    }

    public String getOwner() {
        String owner = System.getProperty("todo.owner");
        logger.info("Todo owner: {}", owner);
        if(owner == null || owner.isEmpty()) {
            return "";
        }
        return owner+"'s";
    }
}
