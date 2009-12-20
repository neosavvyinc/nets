package com.neosavvy.user.dto;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 18, 2009
 * Time: 11:57:55 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(
    name="USER_INVITE" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
            ,@UniqueConstraint(columnNames = {"EMAIL_ADDRESS"})
    }
)
public class UserInviteDTO extends BaseUserDTO{

}
