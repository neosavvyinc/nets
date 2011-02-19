package com.neosavvy.user.dao;

import com.neosavvy.user.dto.NumEmployeesRangeDTO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 5, 2009
 * Time: 1:18:23 PM
 * To change this template use File | Settings | File Templates.
 */
public interface NumEmployeesRangeDAO {
    public List<NumEmployeesRangeDTO> getRanges();

	public void saveRange(NumEmployeesRangeDTO range);

	public NumEmployeesRangeDTO findRangeById(int id);

	public List<NumEmployeesRangeDTO> findRanges(NumEmployeesRangeDTO range);

    public void deleteRange(NumEmployeesRangeDTO range);
}
