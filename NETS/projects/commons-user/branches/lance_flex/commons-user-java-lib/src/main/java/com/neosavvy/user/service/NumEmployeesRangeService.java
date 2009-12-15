package com.neosavvy.user.service;

import com.neosavvy.user.dto.NumEmployeesRangeDTO;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 13, 2009
 * Time: 11:51:06 PM
 * To change this template use File | Settings | File Templates.
 */
@Transactional
public interface NumEmployeesRangeService {
    public List<NumEmployeesRangeDTO> getNumEmployeesRange();
}
