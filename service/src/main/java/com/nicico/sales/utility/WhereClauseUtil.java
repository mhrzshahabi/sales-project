package com.nicico.sales.utility;

import com.nicico.copper.common.dto.search.SearchDTO;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class WhereClauseUtil {

    private final SearchDTO.CriteriaRq criteria;
    private final List<SearchDTO.SortByRq> sortByList;

    private WhereClauseUtil(SearchDTO.CriteriaRq criteria, List<SearchDTO.SortByRq> sortByList) {
        this.criteria = criteria;
        this.sortByList = sortByList;
    }

    public static WhereClauseUtil of(SearchDTO.CriteriaRq criteria) {
        return new WhereClauseUtil(criteria, null);
    }

    public static WhereClauseUtil of(SearchDTO.CriteriaRq criteria, List<SearchDTO.SortByRq> sortByList) {
        return new WhereClauseUtil(criteria, sortByList);
    }

    public static WhereClauseUtil of(SearchDTO.SearchRq request) {
        return request.getCriteria() != null ? new WhereClauseUtil(request.getCriteria(), request.getSortBy()) : new WhereClauseUtil(null, request.getSortBy());
    }

    public String getSortBy() {

        String sort = "";
        if (this.sortByList != null && !this.sortByList.isEmpty()) {
            sort = sort + "ORDER BY " + this.createSort(this.sortByList);
        }

        return sort;
    }

    public String getWhereClause() {

        String whereClause = "";
        if (this.criteria != null) {
            whereClause = whereClause + "WHERE " + this.createWhereClause(this.criteria);
        }

        return whereClause;
    }

    private String createWhereClause(SearchDTO.CriteriaRq criteria) {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("(");
        switch (criteria.getOperator()) {
            case and:
                if (!CollectionUtils.isEmpty(criteria.getCriteria())) {
                    stringBuilder.append(this.createWhereClause(criteria.getCriteria().get(0)));
                    IntStream.range(1, criteria.getCriteria().size()).mapToObj((index) -> {
                        return criteria.getCriteria().get(index);
                    }).forEach((criteriaRq) -> {
                        stringBuilder.append(" AND ").append(this.createWhereClause(criteriaRq));
                    });
                }
                break;
            case or:
                if (!CollectionUtils.isEmpty(criteria.getCriteria())) {
                    stringBuilder.append(this.createWhereClause(criteria.getCriteria().get(0)));
                    IntStream.range(1, criteria.getCriteria().size()).mapToObj((index) -> {
                        return criteria.getCriteria().get(index);
                    }).forEach((criteriaRq) -> {
                        stringBuilder.append(" OR ").append(this.createWhereClause(criteriaRq));
                    });
                }
            case not:
                break;
            default:
                stringBuilder.append(this.createComparisonWhereClause(criteria));
        }

        stringBuilder.append(")");
        return stringBuilder.toString();
    }

    private String createSort(List<SearchDTO.SortByRq> sortByList) {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append(sortByList.get(0).getFieldName()).append(" ").append(sortByList.get(0).getDescendingSafe() ? "DESC" : "ASC");
        IntStream.range(1, sortByList.size()).mapToObj(sortByList::get).forEach((sortByRq) -> {
            stringBuilder.append(",").append(" ").append(sortByRq.getFieldName()).append(" ").append(sortByRq.getDescendingSafe() ? "DESC" : "ASC");
        });
        return stringBuilder.toString();
    }

    private String createComparisonWhereClause(SearchDTO.CriteriaRq criteria) {
        StringBuilder stringBuilder = new StringBuilder();
        switch (criteria.getOperator()) {
            case iEquals:
            case equals:
                stringBuilder.append(criteria.getFieldName()).append(" IN ").append(this.convertAsList(criteria));
                break;
            case iNotEqual:
            case notEqual:
                stringBuilder.append(criteria.getFieldName()).append(" NOT IN ").append(this.convertAsList(criteria));
                break;
            case lessThan:
                stringBuilder.append(criteria.getFieldName()).append(" < ").append(this.convertAsSingle(criteria));
                break;
            case lessOrEqual:
                stringBuilder.append(criteria.getFieldName()).append(" <= ").append(this.convertAsSingle(criteria));
                break;
            case greaterThan:
                stringBuilder.append(criteria.getFieldName()).append(" > ").append(this.convertAsSingle(criteria));
                break;
            case greaterOrEqual:
                stringBuilder.append(criteria.getFieldName()).append(" >= ").append(this.convertAsSingle(criteria));
                break;
            case iStartsWith:
            case startsWith:
                stringBuilder.append(criteria.getFieldName()).append(" LIKE '").append(this.convertAsSingle(criteria)).append("%'");
                break;
            case iNotStartsWith:
            case notStartsWith:
                stringBuilder.append(criteria.getFieldName()).append(" NOT LIKE '").append(this.convertAsSingle(criteria)).append("%'");
                break;
            case iEndsWith:
            case endsWith:
                stringBuilder.append(criteria.getFieldName()).append(" LIKE '").append("%").append(this.convertAsSingle(criteria) + "'");
                break;
            case iNotEndsWith:
            case notEndsWith:
                stringBuilder.append(criteria.getFieldName()).append(" NOT LIKE '").append("%").append(this.convertAsSingle(criteria) + "'");
                break;
            case iContains:
            case contains:
                stringBuilder.append(criteria.getFieldName()).append(" LIKE ").append("'%").append(this.convertAsSingle(criteria)).append("%'");
                break;
            case iNotContains:
            case notContains:
                stringBuilder.append(criteria.getFieldName()).append(" NOT LIKE ").append("'%").append(this.convertAsSingle(criteria)).append("%'");
                break;
            case iBetween:
            case between:
                stringBuilder.append(criteria.getFieldName()).append(" > ").append(this.convertAsSingle(criteria, 0)).append(" AND ").append(criteria.getFieldName()).append(" < ").append(this.convertAsSingle(criteria, 1));
                break;
            case iBetweenInclusive:
            case betweenInclusive:
                stringBuilder.append(criteria.getFieldName()).append(" BETWEEN ").append(this.convertAsSingle(criteria, 0)).append(" AND ").append(this.convertAsSingle(criteria, 1));
                break;
            case isBlank:
                stringBuilder.append(criteria.getFieldName()).append(" LIKE ").append("''");
                break;
            case notBlank:
                stringBuilder.append(criteria.getFieldName()).append(" NOT LIKE ").append("''");
                break;
            case isNull:
                stringBuilder.append(criteria.getFieldName()).append(" IS NULL");
                break;
            case notNull:
                stringBuilder.append(criteria.getFieldName()).append(" IS NOT NULL");
                break;
            case inSet:
                stringBuilder.append(criteria.getFieldName()).append(" IN ").append(this.convertAsList(criteria));
                break;
            default:
                throw new RuntimeException("Invalid comparison Operator: " + criteria.getOperator());
        }

        return stringBuilder.toString();
    }

    private Comparable convertAsSingle(SearchDTO.CriteriaRq criteria) {
        return this.convertAsSingle(criteria, 0);
    }

    private Comparable convertAsSingle(SearchDTO.CriteriaRq criteria, int index) {
        return criteria.getValue() != null && criteria.getValue().size() > index ? this.convert(criteria.getValue().get(index)) : null;
    }

    private List<Comparable> convertAsList(SearchDTO.CriteriaRq criteria) {
        return criteria.getValue() != null && !criteria.getValue().isEmpty() ? criteria.getValue().stream().map(this::convert).collect(Collectors.toList()) : null;
    }

    private String convert(Object value) {
        return String.valueOf(value);
    }
}
