package com.gepardec.examples.todowildflyswarm.persistence.dao;

import com.gepardec.examples.todowildflyswarm.persistence.model.Todo;
import org.apache.deltaspike.data.api.EntityRepository;
import org.apache.deltaspike.data.api.Repository;
import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
@Repository
public interface TodoRepository extends EntityRepository<Todo, Long> {
}
