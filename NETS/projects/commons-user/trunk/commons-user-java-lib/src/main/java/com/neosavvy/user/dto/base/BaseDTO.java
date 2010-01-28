package com.neosavvy.user.dto.base;

/**
 * Created by IntelliJ IDEA.
 * User: tommyodom
 * Date: Jan 18, 2010
 * Time: 6:22:23 PM
 * To change this template use File | Settings | File Templates.
 */
public abstract class BaseDTO {
    public abstract Long getId();

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof BaseDTO)) return false;

        BaseDTO baseDTO = (BaseDTO) o;

        if (getId() != null ? !getId().equals(baseDTO.getId()) : baseDTO.getId() != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return getId() != null ? getId().hashCode() : 0;
    }
}
