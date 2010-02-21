package com.neosavvy.user.dao.base;

import org.springframework.orm.jpa.EntityManagerProxy;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

public class BaseDAO {
    @PersistenceContext
    private EntityManager entityManager;

    public EntityManager getEntityManager() {
        // This is a hack to work around ClassNotFound errors and other weirdness from eclipselink
        // when using spring & the criteria builder.  Spring 3.0 shortcuts the getCriteriaBuilder
        // call in their proxy because they believe it's not really necessary to have an actual
        // instantiated entitymanager since it can be called on the entity manager factory but
        // eclipselink doesn't play nice with that behavior.  Eclipselink looks like they are trying
        // to have the issue resolved in 2.0.2.
        // Spring bug (resolved won't fix): http://jira.springframework.org/browse/SPR-6826
        // Eclipselink bug (target 2.0.2): https://bugs.eclipse.org/bugs/show_bug.cgi?id=303063
        if (entityManager != null) {
            ((EntityManagerProxy)entityManager).getTargetEntityManager();
        }
        return entityManager;
    }

    public void setEntityManager(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

}
