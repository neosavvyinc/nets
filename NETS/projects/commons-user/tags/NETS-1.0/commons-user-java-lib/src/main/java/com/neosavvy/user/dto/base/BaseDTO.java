package com.neosavvy.user.dto.base;

public abstract class BaseDTO {
    public abstract Long getId();

    protected BaseDTO() {}

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BaseDTO baseDTO = (BaseDTO) o;

        if (getId() != null ? !getId().equals(baseDTO.getId()) : baseDTO.getId() != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return getId() != null ? getId().hashCode() : super.hashCode();
    }
}
