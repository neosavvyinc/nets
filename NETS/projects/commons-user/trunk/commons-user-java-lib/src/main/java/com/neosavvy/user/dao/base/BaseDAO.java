package com.neosavvy.user.dao.base;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Nov 28, 2009
 * Time: 4:42:04 AM
 * To change this template use File | Settings | File Templates.
 */
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
