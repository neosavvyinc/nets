package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dao.base.BaseDAO;
import com.neosavvy.user.dto.companyManagement.UserInviteDTO;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: lgleason
 * Date: Dec 19, 2009
 * Time: 11:30:52 PM
 * To change this template use File | Settings | File Templates.
 */
public class UserInviteDAOImpl extends BaseDAO implements UserInviteDAO{
    public UserInviteDTO saveUserInvite(UserInviteDTO userInvite) {
        if (userInvite.getId() == null) {
            getEntityManager().persist(userInvite);
        }
        else {
            userInvite = getEntityManager().merge(userInvite);
        }
        getEntityManager().flush();
        return userInvite;
    }

    public UserInviteDTO findUserInviteById(long id) {
        return getEntityManager().find(UserInviteDTO.class, id);
    }

    public List<UserInviteDTO> findUserInvites(UserInviteDTO userInvite) {
        CriteriaBuilder builder = getEntityManager().getCriteriaBuilder();
        CriteriaQuery<UserInviteDTO> criteria = builder.createQuery(UserInviteDTO.class);
        Root<UserInviteDTO> root = criteria.from(UserInviteDTO.class);
        List<Predicate> searchPredicates = new ArrayList<Predicate>();

        if((userInvite.getFirstName() != null) && (userInvite.getFirstName().length() > 0)){
            searchPredicates.add(builder.equal(root.get("firstName"), userInvite.getFirstName()));
        }
        if((userInvite.getMiddleName() != null) && (userInvite.getMiddleName().length() > 0)){
            searchPredicates.add(builder.equal(root.get("middleName"), userInvite.getMiddleName()));
        }
        if((userInvite.getLastName() != null) && (userInvite.getLastName().length() > 0)){
            searchPredicates.add(builder.equal(root.get("lastName"), userInvite.getLastName()));
        }
        if((userInvite.getEmailAddress() != null) && (userInvite.getEmailAddress().length() > 0)){
            searchPredicates.add(builder.equal(root.get("emailAddress"), userInvite.getEmailAddress()));
        }
        if((userInvite.getRegistrationToken() != null) && (userInvite.getRegistrationToken().length() > 0)){
            searchPredicates.add(builder.equal(root.get("registrationToken"), userInvite.getRegistrationToken()));
        }

        return getEntityManager().createQuery(criteria.where(searchPredicates.toArray(new Predicate[0]))).getResultList();

    }

    public void deleteUserInvite(UserInviteDTO userInvite) {
        getEntityManager().remove(userInvite);
        getEntityManager().flush();
    }
}
