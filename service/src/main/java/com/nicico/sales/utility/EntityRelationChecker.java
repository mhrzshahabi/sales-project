package com.nicico.sales.utility;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.persistence.EntityManager;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.persistence.metamodel.Attribute;
import javax.persistence.metamodel.EntityType;
import java.util.*;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class EntityRelationChecker {

    @Autowired
    protected EntityManager entityManager;

    private Map<Class<? extends BaseEntity>, Map<Class<? extends BaseEntity>, Set<String>>> relatedToEntity = new HashMap<>();

    public Set<Class<? extends BaseEntity>> getRelatedEntities(Class<? extends BaseEntity> entityClass) {
        if (relatedToEntity.get(entityClass) == null)
            fillRelationMap(entityClass);
        return relatedToEntity.get(entityClass).keySet();
    }

    public Map<Class<? extends BaseEntity>, List<BaseEntity>> getRecordRelations(Class<? extends BaseEntity> entityClass, Long id, Collection<Class<? extends BaseEntity>> ignoreList) {
        Map<Class<? extends BaseEntity>, List<BaseEntity>> relatedRecords = new HashMap<>();
        if (relatedToEntity.get(entityClass) == null)
            fillRelationMap(entityClass);
        for (Class<? extends BaseEntity> entityType : relatedToEntity.get(entityClass).keySet()) {
            if (ignoreList != null && ignoreList.contains(entityType))
                continue;
            Set<String> fields = relatedToEntity.get(entityClass).get(entityType);
            CriteriaBuilder cb = entityManager.getCriteriaBuilder();
            CriteriaQuery<? extends BaseEntity> query = cb.createQuery(entityType);
            Root root = query.from(entityType);
            Iterator<String> iterator = fields.iterator();
            Predicate whereClause = cb.equal(root.get(iterator.next()), id);
            while (iterator.hasNext()) {
                whereClause = cb.or(whereClause, cb.equal(root.get(iterator.next()), id));
            }
            CriteriaQuery<BaseEntity> select = query.where(whereClause).select(root);
            List<BaseEntity> resultList = entityManager.createQuery(select).getResultList();
            if (!resultList.isEmpty())
                relatedRecords.put(entityType, resultList);
        }

        return relatedRecords;
    }


    public Map<Class<? extends BaseEntity>, List<BaseEntity>> getRecordRelations(Class<? extends BaseEntity> entityClass, Long id) {
        return getRecordRelations(entityClass, id, null);
    }

    private void fillRelationMap(Class<? extends BaseEntity> entityClass) {
        Set<EntityType<?>> entities = entityManager.getMetamodel().getEntities();
        Map<Class<? extends BaseEntity>, Set<String>> relationMap = new HashMap<>();
        for (EntityType<?> entityType : entities) {

            List<Attribute<?, ?>> list = entityType.getAttributes().stream()
                    .filter(attribute -> attribute.getJavaType().equals(entityClass))
                    .collect(Collectors.toList());

            if (!list.isEmpty()) {
                for (Attribute<?, ?> attribute : list) {
                    Set fields = relationMap.get(entityType);
                    if (fields == null)
                        fields = new HashSet<String>();
                    fields.add(attribute.getName());
                    relationMap.put((Class<? extends BaseEntity>) entityType.getJavaType(), fields);
                }
            }

        }
        relatedToEntity.put(entityClass, relationMap);
    }


}
