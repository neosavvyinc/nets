package com.neosavvy.user.dao;

import com.neosavvy.user.dto.CompanyDTO;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.hibernate.classic.Session;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Nov 27, 2009
 * Time: 2:53:27 PM
 * To change this template use File | Settings | File Templates.
 */
public class CompanyDAOImpl implements CompanyDAO{
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

    public List<CompanyDTO> getCompanies() {
        return getCurrentSession().createCriteria(CompanyDTO.class).list();
    }

    public void saveCompany(CompanyDTO company) {
		getCurrentSession().saveOrUpdate(company);
        getCurrentSession().flush();
        //To change body of implemented methods use File | Settings | File Templates.
    }

    public CompanyDTO findCompanyById(int id) {
        return (CompanyDTO) getCurrentSession()
            .createCriteria(CompanyDTO.class)
            .add( Restrictions.idEq(id) )
            .uniqueResult();
    }

    public List<CompanyDTO> findCompanies(CompanyDTO company) {
        Criteria criteria = getCurrentSession().createCriteria(CompanyDTO.class);
        if(company.getCompanyName() != null && company.getCompanyName().length() > 0) {
            criteria.add(Restrictions.eq("companyName", company.getCompanyName()));
        }
        if(company.getCity() != null && company.getCity().length() > 0) {
            criteria.add(Restrictions.eq("city", company.getCity()));
        }
        if(company.getState() != null && company.getState().length() > 0) {
            criteria.add(Restrictions.eq("state", company.getState()));
        }
        if(company.getPostalCode() != null && company.getPostalCode().length() > 0) {
            criteria.add(Restrictions.eq("postalCode", company.getPostalCode()));
        }
		return criteria.list();
    }
}
