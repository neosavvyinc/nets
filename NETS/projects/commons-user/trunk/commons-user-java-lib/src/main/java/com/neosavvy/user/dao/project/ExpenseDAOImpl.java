package com.neosavvy.user.dao.project;

import com.neosavvy.user.dao.base.BaseDAO;
import com.neosavvy.user.dto.companyManagement.CompanyDTO;
import com.neosavvy.user.dto.project.*;

import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.*;

public class ExpenseDAOImpl extends BaseDAO implements ExpenseDAO {

    public List<? extends PaymentMethod> getStandardPaymentMethods() {
        CriteriaBuilder builder = getEntityManager().getCriteriaBuilder();
        CriteriaQuery<StandardPaymentMethod> criteria = builder.createQuery(StandardPaymentMethod.class);
        Root<StandardPaymentMethod> root = criteria.from(StandardPaymentMethod.class);
        return getEntityManager().createQuery(criteria).getResultList();
    }

    public List<? extends PaymentMethod> getCompanyPaymentMethods(CompanyDTO company) {
        CriteriaBuilder builder = getEntityManager().getCriteriaBuilder();
        CriteriaQuery<CompanyPaymentMethod> criteria = builder.createQuery(CompanyPaymentMethod.class);
        Root<CompanyPaymentMethod> root = criteria.from(CompanyPaymentMethod.class);
        criteria.where(builder.equal(root.get("company"), company));
        return getEntityManager().createQuery(criteria).getResultList();
    }

    public List<? extends ExpenseItemType> getStandardExpenseItemTypes() {
        CriteriaBuilder builder = getEntityManager().getCriteriaBuilder();
        CriteriaQuery<StandardExpenseItemType> criteria = builder.createQuery(StandardExpenseItemType.class);
        Root<StandardExpenseItemType> root = criteria.from(StandardExpenseItemType.class);
        return getEntityManager().createQuery(criteria).getResultList();
    }

    public List<? extends ExpenseItemType> getCompanyExpenseItemTypes(CompanyDTO company) {
        CriteriaBuilder builder = getEntityManager().getCriteriaBuilder();
        CriteriaQuery<CompanyExpenseItemType> criteria = builder.createQuery(CompanyExpenseItemType.class);
        Root<CompanyExpenseItemType> root = criteria.from(CompanyExpenseItemType.class);
        criteria.where(builder.equal(root.get("company"), company));
        return getEntityManager().createQuery(criteria).getResultList();
    }

    public List<ProjectType> getProjectTypes() {
        CriteriaBuilder builder = getEntityManager().getCriteriaBuilder();
        CriteriaQuery<ProjectType> criteria = builder.createQuery(ProjectType.class);
        Root<ProjectType> root = criteria.from(ProjectType.class);
        return getEntityManager().createQuery(criteria).getResultList();
    }

    public ExpenseReport save(ExpenseReport report) {
        prepareForSave(report);

        if (report.getId() == null) {
            // no need to explicitly call save on our items, we know
            // that the persist will take care of it for us
            getEntityManager().persist(report);
        }
        else {
            List<ExpenseItem> savedItems = new ArrayList<ExpenseItem>();
            for (ExpenseItem item : report.getExpenseItems()) {
                savedItems.add(save(item));
            }
            report.setExpenseItems(savedItems);
            report = getEntityManager().merge(report);
        }

        getEntityManager().flush();
        return report;
    }

    public ExpenseItem save(ExpenseItem item) {
        prepareForSave(item);

        if (item.getId() == null) {
            getEntityManager().persist(item);
        }
        else {
            Set<ExpenseItemValue> savedValues = new HashSet<ExpenseItemValue>();

            for (ExpenseItemValue value : item.getExpenseItemValues()) {
                savedValues.add(save(value));
            }
            item.setExpenseItemValues(savedValues);
            item = getEntityManager().merge(item);
        }

        getEntityManager().flush();
        return item;
    }

    private void prepareForSave(ExpenseReport report) {
        if (report.getExpenseItems() != null) {
            for (ExpenseItem item : report.getExpenseItems()) {
                item.setExpenseReport(report);
                prepareForSave(item);
            }
        }
    }

    private void prepareForSave(ExpenseItem item) {
        if (item.getExpenseItemValues() != null) {
            for (ExpenseItemValue value : item.getExpenseItemValues()) {
                value.setExpenseItem(item);
            }
        }
    }

    public ExpenseItemValue save(ExpenseItemValue value) {
        if (value.getId() == null) {
            getEntityManager().persist(value);
        }
        else {
            value = getEntityManager().merge(value);
        }

        getEntityManager().flush();
        return value;
    }

    public void delete(ExpenseReport report) {
        getEntityManager().remove(report);
        getEntityManager().flush();
    }

    public ExpenseReport findExpenseReportById(long id) {
        ExpenseReport report = getEntityManager().find(ExpenseReport.class, id);
        getEntityManager().refresh(report);
        return report;
    }

    public List<ExpenseReport> findExpenseReports(ExpenseReport filter) {
        CriteriaBuilder builder = getEntityManager().getCriteriaBuilder();
        CriteriaQuery<ExpenseReport> query = builder.createQuery(ExpenseReport.class);
        Root<ExpenseReport> root = query.from(ExpenseReport.class);
        List<Predicate> predicates = new ArrayList<Predicate>();

        if (filter.getStartDate() != null) {
            predicates.add(builder.equal(root.get("startDate"), filter.getStartDate()));
        }
        if (filter.getEndDate() != null) {
            predicates.add(builder.equal(root.get("endDate"), filter.getEndDate()));
        }
        if (filter.getLocation() != null) {
            predicates.add(builder.equal(root.get("location"), filter.getLocation()));
        }
        if (filter.getOwner() != null) {
            predicates.add(builder.equal(root.get("owner"), filter.getOwner()));
        }
        if (filter.getProject() != null) {
            predicates.add(builder.equal(root.get("project"), filter.getProject()));
        }
        if (filter.getPurpose() != null) {
            predicates.add(builder.equal(root.get("purpose"), filter.getPurpose()));
        }
        if (filter.getStatus() != null) {
            predicates.add(builder.equal(root.get("status"), filter.getStatus()));
        }
        query.where(predicates.toArray(new Predicate[0]));
        return getEntityManager().createQuery(query).getResultList();
    }

    public List<ExpenseItem> findExpenseItemsForReport(long reportId) {
        Query query = getEntityManager().createQuery("SELECT i FROM ExpenseItem i WHERE i.expenseReport.id = :reportId");
        query.setParameter("reportId", reportId);
        return query.getResultList();
    }
}
