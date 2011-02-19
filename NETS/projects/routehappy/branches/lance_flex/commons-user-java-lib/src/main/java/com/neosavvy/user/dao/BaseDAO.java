package com.neosavvy.user.dao;

import org.hibernate.SessionFactory;
import org.hibernate.classic.Session;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Nov 28, 2009
 * Time: 4:42:04 AM
 * To change this template use File | Settings | File Templates.
 */
public class BaseDAO {
    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public SessionFactory getSessionFactory() {
        return this.sessionFactory;
    }

    protected Session getCurrentSession() {
        return getSessionFactory().getCurrentSession();
    }    
}
