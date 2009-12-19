package com.neosavvy.user.dto;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.Set;
import java.util.LinkedHashSet;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 5, 2009
 * Time: 1:03:49 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(
    name="NUM_EMPLOYEES_RANGE" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
@XmlRootElement
public class NumEmployeesRangeDTO {
    @Id
    @GeneratedValue
    @Column(name="ID")
    private int id;

    @Column(name="RANGE_DESCRIPTION")
    private String rangeDescription;

    @Column(name="RANGE_FROM")
    private int rangeFrom;

    @Column(name="RANGE_TO")
    private int rangeTo;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRangeDescription() {
        return rangeDescription;
    }

    public void setRangeDescription(String rangeDescription) {
        this.rangeDescription = rangeDescription;
    }

    public int getRangeFrom() {
        return rangeFrom;
    }

    public void setRangeFrom(int rangeFrom) {
        this.rangeFrom = rangeFrom;
    }

    public int getRangeTo() {
        return rangeTo;
    }

    public void setRangeTo(int rangeTo) {
        this.rangeTo = rangeTo;
    }
}
