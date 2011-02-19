package com.neosavvy.user.dao;

import com.neosavvy.user.dto.NumEmployeesRangeDTO;

import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.Criteria;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 5, 2009
 * Time: 1:24:39 PM
 * To change this template use File | Settings | File Templates.
 */
public class NumEmployeesRangeDAOImpl extends BaseDAO implements NumEmployeesRangeDAO{
    public List<NumEmployeesRangeDTO> getRanges() {
        return getCurrentSession().createCriteria(NumEmployeesRangeDTO.class).list();
    }

    public void saveRange(NumEmployeesRangeDTO range) {
        getCurrentSession().saveOrUpdate(range);
        getCurrentSession().flush();
    }

    public NumEmployeesRangeDTO findRangeById(int id) {
        return (NumEmployeesRangeDTO) getCurrentSession()
            .createCriteria(NumEmployeesRangeDTO.class)
            .add( Restrictions.idEq(id) )
            .uniqueResult();
    }

    public List<NumEmployeesRangeDTO> findRanges(NumEmployeesRangeDTO range) {
        Criteria criteria = getCurrentSession().createCriteria(NumEmployeesRangeDTO.class);
        if(range.getRangeDescription() != null && range.getRangeDescription().length() > 0) {
            criteria.add(Restrictions.eq("rangeDescription", range.getRangeDescription()));
        }
        if(range.getRangeFrom() > 0) {
            criteria.add(Restrictions.eq("rangeFrom", range.getRangeFrom()));
        }
        if(range.getRangeTo() > 0) {
            criteria.add(Restrictions.eq("rangeTo", range.getRangeTo()));
        }
        return criteria.list();  //To change body of implemented methods use File | Settings | File Templates.
    }

    public void deleteRange(NumEmployeesRangeDTO range) {
        getCurrentSession().delete(range);
        getCurrentSession().flush();
    }
}
