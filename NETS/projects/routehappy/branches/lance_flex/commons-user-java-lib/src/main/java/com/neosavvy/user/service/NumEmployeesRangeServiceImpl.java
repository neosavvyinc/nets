package com.neosavvy.user.service;

import org.springframework.transaction.annotation.Transactional;
import com.neosavvy.user.dto.NumEmployeesRangeDTO;
import com.neosavvy.user.dao.NumEmployeesRangeDAO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 13, 2009
 * Time: 11:53:28 PM
 * To change this template use File | Settings | File Templates.
 */
public class NumEmployeesRangeServiceImpl implements NumEmployeesRangeService{
    private NumEmployeesRangeDAO numEmployeesRangeDao;

    public List<NumEmployeesRangeDTO> getNumEmployeesRange() {
        return numEmployeesRangeDao.getRanges();
    }

    public NumEmployeesRangeDAO getNumEmployeesRangeDao() {
        return numEmployeesRangeDao;
    }

    public void setNumEmployeesRangeDao(NumEmployeesRangeDAO numEmployeesRangeDao) {
        this.numEmployeesRangeDao = numEmployeesRangeDao;
    }
}
