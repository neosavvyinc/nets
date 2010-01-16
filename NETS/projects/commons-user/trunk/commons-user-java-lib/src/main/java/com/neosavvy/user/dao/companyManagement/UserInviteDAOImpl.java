package com.neosavvy.user.dao.companyManagement;

import com.neosavvy.user.dao.base.BaseDAO;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.companyManagement.UserInviteDTO;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;

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
        if((userInvite.getCompany() != null) && (userInvite.getCompany().getId() != null)) {
            searchPredicates.add(builder.equal(root.get("company"), userInvite.getCompany()));
        }

        return getEntityManager().createQuery(criteria.where(searchPredicates.toArray(new Predicate[0]))).getResultList();

    }

    public void deleteUserInvite(UserInviteDTO userInvite) {
        userInvite = findUserInviteById(userInvite.getId());
        getEntityManager().remove(userInvite);
        getEntityManager().flush();
    }
}
