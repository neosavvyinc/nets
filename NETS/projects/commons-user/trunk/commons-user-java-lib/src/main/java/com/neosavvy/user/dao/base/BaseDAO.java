package com.neosavvy.user.dao.base;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

public class BaseDAO {
    @PersistenceContext
    private EntityManager entityManager;

    public EntityManager getEntityManager() {
        return entityManager;
    }

    public void setEntityManager(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

}
